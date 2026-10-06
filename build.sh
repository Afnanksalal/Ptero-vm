#!/bin/bash
# Build pterovm.jar for x86_64, aarch64, and riscv64.
# Cross builds need qemu-user-static on the host (qemu-aarch64-static, qemu-riscv64-static).
set -euo pipefail

SRC=$(cd "$(dirname "$0")" && pwd)
ROOT=${PTEROVM_BUILD:-"$HOME/pterovm-build"}
PROOT_VER=5.4.0
HOST=$(uname -m)
rm -rf "$ROOT"
mkdir -p "$ROOT/classes"
cd "$ROOT"

echo "finding alpine version"
LIST=$(curl -4 -fsSL --connect-timeout 15 https://dl-cdn.alpinelinux.org/alpine/latest-stable/releases/x86_64/latest-releases.yaml)
VER=$(printf '%s\n' "$LIST" | awk '/branch: / {print $2; exit}')
if [ -z "$VER" ]; then
    echo "could not find alpine branch" >&2
    exit 1
fi
echo "alpine branch $VER on host $HOST"

download_proot() {
    arch=$1
    echo "downloading proot $arch"
    curl -4 -fL --retry 3 --connect-timeout 15 \
        -o "proot-$arch" \
        "https://github.com/ysdragon/proot-static/releases/download/v${PROOT_VER}/proot-${arch}-static"
    chmod 755 "proot-$arch"
}

build_rootfs() {
    arch=$1
    echo "==== $arch"
    list=$(curl -4 -fsSL --connect-timeout 15 \
        "https://dl-cdn.alpinelinux.org/alpine/latest-stable/releases/${arch}/latest-releases.yaml")
    file=$(printf '%s\n' "$list" | awk -v a="$arch" 'index($0, "alpine-minirootfs-") && index($0, a".tar.gz") {print $2; exit}')
    if [ -z "$file" ]; then
        echo "could not find alpine minirootfs for $arch" >&2
        exit 1
    fi
    echo "alpine $file"
    curl -4 -fL --retry 3 --connect-timeout 15 -o minirootfs.tar.gz \
        "https://dl-cdn.alpinelinux.org/alpine/latest-stable/releases/${arch}/$file"

    rm -rf rootfs
    mkdir -p rootfs
    tar -xzf minirootfs.tar.gz -C rootfs
    rm -f minirootfs.tar.gz
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

    q=()
    if [ "$arch" != "$HOST" ]; then
        qemu="/usr/bin/qemu-${arch}-static"
        if [ ! -x "$qemu" ]; then
            echo "missing $qemu (install qemu-user-static to cross-build $arch)" >&2
            exit 1
        fi
        cp "$qemu" "rootfs$qemu"
        q=(-q "$qemu")
    fi

    echo "installing desktop packages for $arch"
    "./proot-$HOST" "${q[@]}" -S rootfs -b /proc -b /dev -b /sys -b /etc/resolv.conf --kill-on-exit \
        /sbin/apk add --no-cache \
        bash coreutils procps nano htop mc \
        xvfb x11vnc fluxbox xterm xsetroot \
        novnc websockify \
        font-dejavu ttf-dejavu fontconfig \
        ca-certificates

    sed -i 's|^root:x:0:0:root:/root:/bin/.*|root:x:0:0:root:/root:/bin/bash|' rootfs/etc/passwd || true
    mkdir -p rootfs/usr/local/bin
    cat > rootfs/usr/local/bin/mc-desktop <<'EOF'
#!/bin/sh
exec xterm -fa 'DejaVu Sans Mono' -fs 11 -title Files -e mc
EOF
    chmod 755 rootfs/usr/local/bin/mc-desktop

    if [ -d rootfs/usr/share/novnc ]; then
        cat > rootfs/usr/share/novnc/index.html <<'EOF'
<!DOCTYPE html>
<meta http-equiv="refresh" content="0; url=vnc.html?autoconnect=true&resize=scale">
<title>PteroVM</title>
EOF
    fi

    rm -rf rootfs/var/cache/apk rootfs/tmp/* "rootfs/usr/bin/qemu-${arch}-static" || true
    tar -C "$ROOT" -czf "rootfs-${arch}.tar.gz" rootfs
    rm -rf rootfs
    ls -lh "proot-$arch" "rootfs-${arch}.tar.gz"
}

for arch in x86_64 aarch64 riscv64; do
    download_proot "$arch"
done

for arch in x86_64 aarch64 riscv64; do
    build_rootfs "$arch"
done

echo "compiling"
javac --release 8 -d classes "$SRC/src/io/pterovm/Main.java"
for arch in x86_64 aarch64 riscv64; do
    jar cfe "pterovm-${arch}.jar" io.pterovm.Main -C classes . \
        "proot-${arch}" "rootfs-${arch}.tar.gz"
    ls -lh "pterovm-${arch}.jar"
    jar tf "pterovm-${arch}.jar"
done
echo BUILD_OK
