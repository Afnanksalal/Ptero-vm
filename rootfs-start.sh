#!/bin/sh
# Desktop inside the embedded Alpine system. The panel port is already public.
set -eu
unset WAYLAND_DISPLAY WAYLAND_SOCKET || true
export HOME=/root
export DISPLAY=:1
export XDG_SESSION_TYPE=x11
export SHELL=/bin/bash
cd /root

GEOMETRY="${VNC_GEOMETRY:-1280x720x24}"
PORT="${SERVER_PORT:-8080}"
# Classic VNC keeps 8 characters. x11vnc -storepasswd writes a binary blob, and
# -passwdfile on this build reads a text line (fgets). A blob with a NUL or
# newline makes x11vnc exit, and a blob without one is not the typed password.
PASS=$(printf '%s' "${VNC_PASSWORD:-pterovm}" | tr -d '\r\n')
PASS=$(printf '%.8s' "$PASS")
if [ -z "$PASS" ]; then
    PASS=pterovm
fi

mkdir -p /root /var/log
mkdir -p /tmp/.X11-unix 2>/dev/null || true
umask 077
printf '%s\n' "$PASS" > /root/vnc.pass
chmod 600 /root/vnc.pass

# Xvfb is not a real X server. -ac lets local clients connect; -noreset keeps
# the screen up if the first client exits.
Xvfb :1 -screen 0 "$GEOMETRY" -ac -noreset >/var/log/xvfb.log 2>&1 &
i=0
while [ ! -e /tmp/.X11-unix/X1 ] && [ "$i" -lt 50 ]; do
    i=$((i + 1))
    sleep 0.1
done

fluxbox >/var/log/fluxbox.log 2>&1 &
xterm -geometry 110x32+24+24 -fa 'DejaVu Sans Mono' -fs 11 -title 'PteroVM' >/var/log/xterm.log 2>&1 &
# Raw VNC stays on localhost. The allocated port is the noVNC page only.
x11vnc -display :1 -rfbport 5900 -localhost -forever -shared -noxdamage \
    -passwdfile /root/vnc.pass >/var/log/x11vnc.log 2>&1 &
sleep 0.4
if ! pidof x11vnc >/dev/null 2>&1; then
    echo "x11vnc failed to start" >&2
    cat /var/log/x11vnc.log >&2 || true
    exit 1
fi

WS="$(command -v websockify || command -v websockify-3.12 || true)"
if [ -z "$WS" ]; then
    echo "websockify is missing from the embedded system" >&2
    exit 1
fi
"$WS" --web /usr/share/novnc "0.0.0.0:${PORT}" localhost:5900 >/var/log/novnc.log 2>&1 &

printf 'PteroVM desktop listening on %s\n' "$PORT"
printf 'Right-click the desktop for a terminal, files, or htop.\n'
# This bash is the panel console. It is not a TTY. The xterm is.
exec /bin/bash --noprofile --norc
