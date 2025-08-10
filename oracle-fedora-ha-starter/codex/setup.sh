#!/usr/bin/env bash
set -euo pipefail
[[ -f .env ]] && source .env

bash scripts/bootstrap-fedora-oci.sh
bash scripts/open-firewall.sh
bash scripts/install-vnc-kde.sh
bash scripts/install-homeassistant-docker.sh
# Opcionales (habilita si quieres dejar todo 100%):
bash scripts/install-plex.sh
bash scripts/install-anydesk.sh
bash scripts/install-rustdesk.sh
# Para Tailscale automático, define TS_AUTHKEY en .env y descomenta:
# bash scripts/install-tailscale.sh

echo "[Codex] Setup completo."
