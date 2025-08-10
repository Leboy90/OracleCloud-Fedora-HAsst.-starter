SHELL := /bin/bash
-include .env

bootstrap:
	sudo bash scripts/bootstrap-fedora-oci.sh
firewall:
	sudo bash scripts/open-firewall.sh
vnc:
	sudo bash scripts/install-vnc-kde.sh
tailscale:
	sudo bash scripts/install-tailscale.sh
ha-docker:
	sudo bash scripts/install-homeassistant-docker.sh
ha-podman:
	sudo bash scripts/install-homeassistant-podman.sh
plex:
	sudo bash scripts/install-plex.sh
anydesk:
	sudo bash scripts/install-anydesk.sh
rustdesk:
	sudo bash scripts/install-rustdesk.sh
all: bootstrap firewall vnc ha-docker
