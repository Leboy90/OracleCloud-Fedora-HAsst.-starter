#!/usr/bin/env bash
set -euo pipefail
source ./.env || true

HA_DATA="${HA_DATA:-/opt/homeassistant}"

echo "[*] Instalando Podman..."
sudo dnf -y install podman

sudo mkdir -p "$HA_DATA"
sudo chmod 777 "$HA_DATA"

echo "[*] Creando servicio systemd (Podman)..."
sudo podman pull ghcr.io/home-assistant/home-assistant:stable
sudo bash -lc 'cat > /etc/systemd/system/home-assistant.service <<UNIT
[Unit]
Description=Home Assistant (Podman)
After=network-online.target
Wants=network-online.target

[Service]
ExecStart=/usr/bin/podman run --rm --name=homeassistant --network=host -e TZ='"${TZ:-America/New_York}"' -v '"$HA_DATA"':/config ghcr.io/home-assistant/home-assistant:stable
ExecStop=/usr/bin/podman stop homeassistant
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
UNIT'
sudo systemctl daemon-reload
sudo systemctl enable --now home-assistant.service

echo "[✓] Home Assistant en http://IP:8123"
