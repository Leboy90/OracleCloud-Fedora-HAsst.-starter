#!/usr/bin/env bash
set -euo pipefail
[[ -f .env ]] && source .env

bash scripts/bootstrap-fedora-oci.sh
bash scripts/open-firewall.sh
bash scripts/install-vnc-kde.sh
bash scripts/install-homeassistant-docker.sh
# Descomenta si quieres Tailscale automáticamente (requiere TS_AUTHKEY en .env)
# bash scripts/install-tailscale.sh
# Opcionales:
# bash scripts/install-plex.sh
# bash scripts/install-anydesk.sh
# bash scripts/install-rustdesk.sh

echo "[Codex] Setup completo."
