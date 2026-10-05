#!/bin/bash
# Build pterovm.jar: static proot + Alpine desktop (Xvfb, fluxbox, xterm, noVNC).
set -euo pipefail

SRC=$(cd "$(dirname "$0")" && pwd)
ROOT=${PTEROVM_BUILD:-"$HOME/pterovm-build"}
rm -rf "$ROOT"
mkdir -p "$ROOT/src" "$ROOT/classes"
cd "$ROOT"

PROOT_URL=https://github.com/ysdragon/proot-static/releases/download/v5.4.0/proot-x86_64-static
echo "downloading proot"
curl -4 -fL --retry 3 --connect-timeout 15 -o proot-x86_64 "$PROOT_URL"
chmod 755 proot-x86_64

echo "finding alpine minirootfs"
LIST=$(curl -4 -fsSL --connect-timeout 15 https://dl-cdn.alpinelinux.org/alpine/latest-stable/releases/x86_64/latest-releases.yaml)
FILE=$(printf '%s\n' "$LIST" | awk '/file: alpine-minirootfs-.*-x86_64\.tar\.gz/ {print $2; exit}')
VER=$(printf '%s\n' "$LIST" | awk '/branch: / {print $2; exit}')
if [ -z "$FILE" ] || [ -z "$VER" ]; then
    echo "could not find alpine minirootfs" >&2
    exit 1
fi
echo "alpine $FILE branch $VER"
curl -4 -fL --retry 3 --connect-timeout 15 -o minirootfs.tar.gz \
    "https://dl-cdn.alpinelinux.org/alpine/latest-stable/releases/x86_64/$FILE"

mkdir -p rootfs
tar -xzf minirootfs.tar.gz -C rootfs
printf 'nameserver 1.1.1.1\nnameserver 8.8.8.8\n' > rootfs/etc/resolv.conf
cat > rootfs/etc/apk/repositories <<EOF
https://dl-cdn.alpinelinux.org/alpine/${VER}/main
https://dl-cdn.alpinelinux.org/alpine/${VER}/community
EOF

cp "$SRC/rootfs-start.sh" rootfs/start.sh
chmod 755 rootfs/start.sh
mkdir -p rootfs/root/.fluxbox
cp "$SRC/rootfs-fluxbox-menu" rootfs/root/.fluxbox/menu
cp "$SRC/rootfs-fluxbox-init" rootfs/root/.fluxbox/init

echo "installing desktop packages"
./proot-x86_64 -S rootfs -b /proc -b /dev -b /sys -b /etc/resolv.conf --kill-on-exit \
    /sbin/apk add --no-cache \
    bash coreutils procps nano htop mc \
    xvfb x11vnc fluxbox xterm xsetroot \
    novnc websockify \
    font-dejavu ttf-dejavu fontconfig \
    ca-certificates

# Root's login shell is bash so new terminals are a real shell.
sed -i 's|^root:x:0:0:root:/root:/bin/.*|root:x:0:0:root:/root:/bin/bash|' rootfs/etc/passwd || true

# Midnight Commander is the file manager. Wrap it so the fluxbox menu can launch it.
cat > rootfs/usr/local/bin/mc-desktop <<'EOF'
#!/bin/sh
exec xterm -fa 'DejaVu Sans Mono' -fs 11 -title Files -e mc
EOF
chmod 755 rootfs/usr/local/bin/mc-desktop

# Opening the allocation with no path should land on the desktop page.
if [ -d rootfs/usr/share/novnc ]; then
    cat > rootfs/usr/share/novnc/index.html <<'EOF'
<!DOCTYPE html>
<meta http-equiv="refresh" content="0; url=vnc.html?autoconnect=true&resize=scale">
<title>PteroVM</title>
EOF
fi

rm -rf rootfs/var/cache/apk rootfs/tmp/* || true
tar -C "$ROOT" -czf rootfs-x86_64.tar.gz rootfs
ls -lh proot-x86_64 rootfs-x86_64.tar.gz

echo "compiling"
javac --release 8 -d classes "$SRC/src/io/pterovm/Main.java"
jar cfe pterovm.jar io.pterovm.Main -C classes . proot-x86_64 rootfs-x86_64.tar.gz
cp -f pterovm.jar "$SRC/pterovm.jar"
ls -lh pterovm.jar "$SRC/pterovm.jar"
jar tf pterovm.jar
echo BUILD_OK
