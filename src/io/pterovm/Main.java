package io.pterovm;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.nio.file.attribute.PosixFilePermission;
import java.util.HashSet;
import java.util.Locale;
import java.util.Set;

/**
 * One jar for Wings-based panels (Pterodactyl, Pelican, Jexactyl, and the other Actyl forks).
 * The panel starts {@code java -jar server.jar}. This process stays in the foreground,
 * binds the desktop to SERVER_PORT, and exits on the egg stop words or SIGTERM.
 */
public final class Main {
    private static volatile Process child;

    public static void main(String[] args) throws Exception {
        if (!isLinux()) {
            System.err.println("PteroVM runs on the Linux container the panel starts.");
            System.exit(1);
        }

        String port = firstEnv("SERVER_PORT", "PORT");
        if (port == null || port.isEmpty()) {
            port = "8080";
        }
        Path home = Paths.get(firstNonEmpty(firstEnv("HOME"), "/home/container"), ".pterovm");
        Files.createDirectories(home);
        String password = firstEnv("VNC_PASSWORD");
        Path saved = home.resolve("vnc.password");
        if (password == null || password.isEmpty()) {
            if (Files.exists(saved)) {
                password = new String(Files.readAllBytes(saved), "UTF-8").trim();
            }
            if (password == null || password.isEmpty()) {
                password = randomPassword();
            }
            // Classic RFB passwords are 8 characters. Persist that exact value.
            if (password.length() > 8) {
                password = password.substring(0, 8);
            }
            Files.write(saved, password.getBytes("UTF-8"));
        } else if (password.length() > 8) {
            password = password.substring(0, 8);
        }
        String arch = arch();
        Path proot = home.resolve("proot");
        Path root = home.resolve("rootfs");
        extractOnce("/proot-" + arch, proot);
        executable(proot);
        if (!Files.isDirectory(root.resolve("bin"))) {
            Path tar = home.resolve("rootfs.tar.gz");
            extractOnce("/rootfs-" + arch + ".tar.gz", tar);
            untar(tar, home);
        }

        String display = "1280x720x24";
        ProcessBuilder pb = new ProcessBuilder(
                proot.toAbsolutePath().toString(),
                "-S", root.toAbsolutePath().toString(),
                "-b", "/proc",
                "-b", "/dev",
                "-b", "/sys",
                "-b", "/etc/resolv.conf",
                "-w", "/root",
                "--kill-on-exit",
                "/bin/sh", "/start.sh"
        );
        pb.environment().remove("WAYLAND_DISPLAY");
        pb.environment().remove("WAYLAND_SOCKET");
        pb.environment().put("DISPLAY", ":1");
        pb.environment().put("XDG_SESSION_TYPE", "x11");
        pb.environment().put("SERVER_PORT", port);
        pb.environment().put("VNC_PASSWORD", password);
        pb.environment().put("VNC_GEOMETRY", display);
        pb.redirectErrorStream(true);
        child = pb.start();

        Runtime.getRuntime().addShutdownHook(new Thread(new Runnable() {
            public void run() {
                Process p = child;
                if (p != null) {
                    p.destroy();
                }
            }
        }));

        System.out.println("PteroVM ready");
        System.out.println("desktop http://<allocation>:" + port + "/vnc.html?autoconnect=true&resize=scale");
        System.out.println("password " + password);

        Thread pump = new Thread(new Runnable() {
            public void run() {
                copy(child.getInputStream(), System.out);
            }
        });
        pump.setDaemon(true);
        pump.start();

        final OutputStream toChild = child.getOutputStream();
        Thread commands = new Thread(new Runnable() {
            public void run() {
                try {
                    BufferedReader in = new BufferedReader(new InputStreamReader(System.in, "UTF-8"));
                    String line;
                    while ((line = in.readLine()) != null) {
                        String word = line.trim().toLowerCase(Locale.ROOT);
                        if (word.equals("stop") || word.equals("end") || word.equals("quit")) {
                            Process p = child;
                            if (p != null) {
                                p.destroy();
                            }
                            return;
                        }
                        toChild.write((line + "\n").getBytes("UTF-8"));
                        toChild.flush();
                    }
                } catch (Exception ignored) {
                    // Console closed. The desktop keeps running until stop or SIGTERM.
                }
            }
        });
        commands.setDaemon(true);
        commands.start();

        int code = child.waitFor();
        System.exit(code);
    }

    private static boolean isLinux() {
        return System.getProperty("os.name", "").toLowerCase(Locale.ROOT).contains("linux");
    }

    private static String arch() {
        String arch = System.getProperty("os.arch", "").toLowerCase(Locale.ROOT);
        if (arch.equals("amd64") || arch.equals("x86_64")) {
            return "x86_64";
        }
        if (arch.equals("aarch64") || arch.equals("arm64")) {
            return "aarch64";
        }
        throw new IllegalStateException("Unsupported architecture: " + arch);
    }

    private static String firstEnv(String... names) {
        for (int i = 0; i < names.length; i++) {
            String value = System.getenv(names[i]);
            if (value != null && value.length() > 0) {
                return value;
            }
        }
        return null;
    }

    private static String firstNonEmpty(String value, String fallback) {
        return value == null || value.isEmpty() ? fallback : value;
    }

    private static void extractOnce(String resource, Path dest) throws Exception {
        if (Files.exists(dest) && Files.size(dest) > 0) {
            return;
        }
        InputStream in = Main.class.getResourceAsStream(resource);
        if (in == null) {
            throw new IllegalStateException("Missing embedded file " + resource);
        }
        try {
            Files.copy(in, dest, StandardCopyOption.REPLACE_EXISTING);
        } finally {
            in.close();
        }
    }

    private static void executable(Path file) throws Exception {
        Set<PosixFilePermission> perms = new HashSet<PosixFilePermission>();
        perms.add(PosixFilePermission.OWNER_READ);
        perms.add(PosixFilePermission.OWNER_WRITE);
        perms.add(PosixFilePermission.OWNER_EXECUTE);
        perms.add(PosixFilePermission.GROUP_READ);
        perms.add(PosixFilePermission.GROUP_EXECUTE);
        perms.add(PosixFilePermission.OTHERS_READ);
        perms.add(PosixFilePermission.OTHERS_EXECUTE);
        Files.setPosixFilePermissions(file, perms);
    }

    private static void untar(Path tar, Path home) throws Exception {
        Process hostTar = new ProcessBuilder(
                "tar", "-xzf", tar.toAbsolutePath().toString(),
                "-C", home.toAbsolutePath().toString())
                .redirectErrorStream(true)
                .start();
        copy(hostTar.getInputStream(), System.err);
        if (hostTar.waitFor() != 0) {
            throw new IllegalStateException("Could not unpack the embedded system");
        }
    }

    private static void copy(InputStream in, OutputStream out) {
        byte[] buf = new byte[4096];
        try {
            int n;
            while ((n = in.read(buf)) >= 0) {
                out.write(buf, 0, n);
                out.flush();
            }
        } catch (Exception ignored) {
            // The panel closed the console, or the child exited.
        }
    }

    private static String randomPassword() {
        String alphabet = "abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ23456789";
        StringBuilder out = new StringBuilder();
        java.util.Random random = new java.util.Random();
        for (int i = 0; i < 8; i++) {
            out.append(alphabet.charAt(random.nextInt(alphabet.length())));
        }
        return out.toString();
    }

    private Main() {
    }
}
