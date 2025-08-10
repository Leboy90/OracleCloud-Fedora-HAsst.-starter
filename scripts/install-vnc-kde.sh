#!/usr/bin/env bash
set -euo pipefail
source ./.env || true

VNC_USER="${VNC_USER:-${SUDO_USER:-$(whoami)}}"
echo "[*] Instalando KDE Plasma + TigerVNC para usuario: $VNC_USER"

sudo dnf -y groupinstall "KDE Plasma Workspaces"
sudo dnf -y install tigervnc-server xorg-x11-fonts

# Configuración de sesión KDE para VNC
sudo -u "$VNC_USER" bash -lc 'mkdir -p ~/.vnc && echo startplasma-x11 > ~/.vnc/xstartup && chmod +x ~/.vnc/xstartup'

# Contraseña VNC
if [[ -n "${VNC_PASS:-}" ]]; then
  echo "[*] Estableciendo contraseña VNC desde variable VNC_PASS"
  sudo -u "$VNC_USER" bash -lc "printf \"%s\n%s\n\n\" \"$VNC_PASS\" \"$VNC_PASS\" | vncpasswd"
else
  echo "[!] Si no definiste VNC_PASS en .env, se te pedirá al primer arranque (vncpasswd)"
fi

# Systemd unit
cat <<SERVICE | sudo tee /etc/systemd/system/vncserver@.service >/dev/null
[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target

[Service]
Type=forking
User=%i
PAMName=login
PIDFile=/home/%i/.vnc/%H:%i.pid
ExecStart=/usr/bin/vncserver :1 -geometry 1600x900 -localhost no
ExecStop=/usr/bin/vncserver -kill :1

[Install]
WantedBy=multi-user.target
SERVICE

sudo systemctl daemon-reload
sudo systemctl enable vncserver@${VNC_USER}.service
sudo systemctl start vncserver@${VNC_USER}.service

echo "[✓] VNC en marcha en :1 (puerto 5901)."
