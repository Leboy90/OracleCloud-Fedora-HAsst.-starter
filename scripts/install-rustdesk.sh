#!/usr/bin/env bash
set -euo pipefail

echo "[*] Instalando RustDesk..."
sudo dnf -y install curl

# Descargar última versión estable (puedes cambiar la URL si sale nueva)
LATEST=$(curl -s https://api.github.com/repos/rustdesk/rustdesk/releases/latest | grep browser_download_url | grep x86_64.rpm | cut -d '"' -f 4)
if [[ -z "$LATEST" ]]; then
    echo "No se encontró URL de RustDesk. Revisa la página oficial."
    exit 1
fi
curl -fsSL "$LATEST" -o /tmp/rustdesk.rpm
sudo dnf -y install /tmp/rustdesk.rpm || sudo rpm -Uvh /tmp/rustdesk.rpm

# Habilitar como servicio
sudo systemctl enable --now rustdesk

# Abrir puertos estándar RustDesk (21111, 21112 TCP)
sudo firewall-cmd --permanent --add-port=21111/tcp
sudo firewall-cmd --permanent --add-port=21112/tcp
sudo firewall-cmd --reload

echo "[✓] RustDesk instalado y en marcha."
