#!/usr/bin/env bash
set -euo pipefail
source ./.env || true

if ! command -v tailscale >/dev/null 2>&1; then
  echo "[*] Instalando Tailscale..."
  curl -fsSL https://tailscale.com/install.sh | sh
fi

sudo systemctl enable --now tailscaled

if [[ -n "${TS_AUTHKEY:-}" ]]; then
  echo "[*] Autenticando con TS_AUTHKEY (login no interactivo)..."
  sudo tailscale up --authkey "$TS_AUTHKEY" --ssh --accept-dns=true --advertise-tags=tag:server || true
else
  echo "[!] Ejecuta 'sudo tailscale up --ssh' si no usas TS_AUTHKEY."
fi

echo "[✓] Tailscale listo."
