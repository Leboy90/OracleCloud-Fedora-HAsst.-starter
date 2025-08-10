#!/usr/bin/env bash
set -euo pipefail

echo "[*] Instalando Plex Media Server..."
sudo dnf -y install curl

LATEST=$(curl -fsSL https://downloads.plex.tv/plex-media-server-new/ | sed -n 's/.*href="\(.*x86_64\.rpm\)".*/\1/p' | head -n1)
if [[ -z "$LATEST" ]]; then
  echo "No pude detectar la última URL de Plex. Descárgala manualmente desde downloads.plex.tv"
  exit 1
fi
curl -fsSL "https://downloads.plex.tv$LATEST" -o /tmp/plex-latest.rpm
sudo dnf -y install /tmp/plex-latest.rpm || sudo rpm -Uvh /tmp/plex-latest.rpm

sudo systemctl enable --now plexmediaserver
echo "[✓] Plex en http://IP:32400/web"
