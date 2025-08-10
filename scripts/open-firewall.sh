#!/usr/bin/env bash
set -euo pipefail

echo "[*] Abriendo puertos en firewalld (22, 5901, 8123, 32400 opcional)..."
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --permanent --add-port=5901/tcp
sudo firewall-cmd --permanent --add-port=8123/tcp
sudo firewall-cmd --permanent --add-port=32400/tcp
sudo firewall-cmd --reload

echo "[✓] Firewall configurado."
