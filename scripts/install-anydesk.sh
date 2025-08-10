#!/usr/bin/env bash
set -euo pipefail

echo "[*] Instalando AnyDesk..."
sudo dnf -y install curl

# Descargar e instalar AnyDesk desde RPM oficial
curl -fsSL https://download.anydesk.com/linux/anydesk-6.3.2-1.el9.x86_64.rpm -o /tmp/anydesk.rpm
sudo dnf -y install /tmp/anydesk.rpm || sudo rpm -Uvh /tmp/anydesk.rpm

# Habilitar servicio
sudo systemctl enable --now anydesk

# Abrir puerto AnyDesk en firewall (6568 TCP/UDP)
sudo firewall-cmd --permanent --add-port=6568/tcp
sudo firewall-cmd --permanent --add-port=6568/udp
sudo firewall-cmd --reload

echo "[✓] AnyDesk instalado y en marcha."
