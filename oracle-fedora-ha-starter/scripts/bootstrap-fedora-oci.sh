#!/usr/bin/env bash
set -euo pipefail

source ./.env || true

echo "[*] Actualizando sistema y paquetes base..."
sudo dnf -y upgrade

echo "[*] Instalando utilidades..."
sudo dnf -y install \
  curl wget git unzip tar nano vim htop net-tools bind-utils lsof \  firewalld policycoreutils-python-utils

echo "[*] Habilitando y arrancando firewalld..."
sudo systemctl enable --now firewalld

if [[ "${DISABLE_SELINUX:-0}" == "1" ]]; then
  echo "[*] Colocando SELinux en permissive y deshabilitando para próximo reboot..."
  sudo setenforce 0 || true
  sudo sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config
fi

echo "[*] Ajustando zona horaria (si se definió TZ=$TZ)..."
if [[ -n "${TZ:-}" ]]; then
  sudo timedatectl set-timezone "$TZ" || true
fi

echo "[✓] Bootstrap listo."
