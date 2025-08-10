#!/usr/bin/env bash
set -euo pipefail

echo "[*] Instalando RustDesk..."
sudo dnf -y install curl jq

# Descargar última versión estable (usa GitHub API)
LATEST=$(curl -s https://api.github.com/repos/rustdesk/rustdesk/releases/latest | jq -r '.assets[] | select(.name | test("x86_64.*\.rpm$")) | .browser_download_url' | head -n1)
if [[ -z "$LATEST" ]]; then
  echo "No se encontró URL de RustDesk. Revisa la página oficial."
  exit 1
fi

curl -fsSL "$LATEST" -o /tmp/rustdesk.rpm
sudo dnf -y install /tmp/rustdesk.rpm || sudo rpm -Uvh /tmp/rustdesk.rpm

sudo systemctl enable --now rustdesk

# Puertos estándar RustDesk (si corres relay propio, ajusta)
sudo firewall-cmd --permanent --add-port=21111/tcp
sudo firewall-cmd --permanent --add-port=21112/tcp
sudo firewall-cmd --reload

echo "[✓] RustDesk instalado y corriendo."
