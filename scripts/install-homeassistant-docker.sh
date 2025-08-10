#!/usr/bin/env bash
set -euo pipefail
source ./.env || true

HA_DATA="${HA_DATA:-/opt/homeassistant}"

echo "[*] Instalando Docker..."
sudo dnf -y install dnf-plugins-core
sudo dnf -y config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf -y install docker-ce docker-ce-cli containerd.io
sudo systemctl enable --now docker

sudo mkdir -p "$HA_DATA"
sudo chmod 777 "$HA_DATA"

echo "[*] Desplegando Home Assistant (Docker)..."
sudo docker pull ghcr.io/home-assistant/home-assistant:stable
sudo docker run -d --name homeassistant \
  --restart=unless-stopped \
  -e TZ="${TZ:-America/New_York}" \
  -v "$HA_DATA":/config \
  --network=host \
  ghcr.io/home-assistant/home-assistant:stable

echo "[✓] Home Assistant en http://IP:8123"
