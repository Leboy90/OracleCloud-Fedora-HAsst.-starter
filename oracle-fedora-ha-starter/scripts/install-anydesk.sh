#!/usr/bin/env bash
set -euo pipefail

echo "[*] Instalando AnyDesk..."
sudo dnf -y install curl

# Nota: URL fija puede cambiar. Ajustar si AnyDesk actualiza el paquete.
curl -fsSL https://download.anydesk.com/linux/anydesk-6.3.2-1.el9.x86_64.rpm -o /tmp/anydesk.rpm
sudo dnf -y install /tmp/anydesk.rpm || sudo rpm -Uvh /tmp/anydesk.rpm

sudo systemctl enable --now anydesk

# Puertos AnyDesk
sudo firewall-cmd --permanent --add-port=6568/tcp
sudo firewall-cmd --permanent --add-port=6568/udp
sudo firewall-cmd --reload

echo "[✓] AnyDesk instalado y corriendo."
