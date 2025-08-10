# oracle-fedora-ha-starter

---

## 🇪🇸 Español

Infraestructura lista para **Oracle Cloud (OCI) + Fedora** con:

- **KDE + TigerVNC** (display `:1` → puerto **5901**) para escritorio remoto  
- **Home Assistant** en **Docker** (o Podman + systemd)  
- **Tailscale** (opcional, con SSH habilitado)  
- **Plex Media Server** (opcional)  
- **AnyDesk** y **RustDesk** (opcionales, acceso remoto 24/7)  
- **firewalld** configurado para abrir:
  - **22** (SSH)  
  - **5901** (VNC)  
  - **8123** (Home Assistant)  
  - **32400** (Plex)  
  - **6568 TCP/UDP** (AnyDesk)  
  - **21111–21112 TCP** (RustDesk)  

> Compatible con Fedora 39+ (probado en 40, 41 y 42).

---

### 🚀 Instalación rápida

```bash
sudo dnf -y install git
git clone https://github.com/Lebov90/oracle-fedora-ha-starter.git
cd oracle-fedora-ha-starter
cp .env.example .env   # ajusta TZ, VNC_USER, VNC_PASS, TS_AUTHKEY, HA_DATA
chmod +x scripts/*.sh

# Bootstrap + firewall + KDE/VNC + HA en Docker
sudo ./scripts/bootstrap-fedora-oci.sh
sudo ./scripts/open-firewall.sh
sudo ./scripts/install-vnc-kde.sh
sudo ./scripts/install-homeassistant-docker.sh

# Opcionales
sudo ./scripts/install-tailscale.sh
sudo ./scripts/install-plex.sh
sudo ./scripts/install-anydesk.sh
sudo ./scripts/install-rustdesk.sh
```

---

### 🖥️ Conexión al escritorio KDE por VNC
1. Cliente VNC → Conectar a `IP_PUBLICA:5901`  
2. Usuario/contraseña según configuraste en `.env` (`VNC_USER`, `VNC_PASS`)  
3. Primer arranque: si `VNC_PASS` está vacío, se te pedirá (`vncpasswd`).

---

### 🌐 Puertos (abrir también en OCI Security Lists / NSG)

| Servicio        | Puerto(s)   | Protocolo |
|-----------------|-------------|-----------|
| SSH             | 22          | TCP       |
| VNC             | 5901        | TCP       |
| Home Assistant  | 8123        | TCP       |
| Plex            | 32400       | TCP       |
| AnyDesk         | 6568        | TCP/UDP   |
| RustDesk        | 21111–21112 | TCP       |

---

### ⚙️ Variables de `.env`

```env
TZ=America/New_York
DISABLE_SELINUX=0
VNC_USER=
VNC_PASS=
TS_AUTHKEY=
HA_DATA=/opt/homeassistant
```

---

### 📦 Docker Compose (opcional para Home Assistant)
```yaml
services:
  homeassistant:
    image: ghcr.io/home-assistant/home-assistant:stable
    container_name: homeassistant
    network_mode: host
    restart: unless-stopped
    environment:
      - TZ=${TZ:-America/New_York}
    volumes:
      - ${HA_DATA:-/opt/homeassistant}:/config
```

---

### 🤖 Uso con Codex (ChatGPT)
1. **Configure repository access** → concede acceso a `Lebov90/oracle-fedora-ha-starter`  
2. Selecciona el repo en Codex  
3. Codex ejecuta `codex/setup.sh` y deja todo instalado

---

### ☁️ Cloud-init para OCI (instalación automática)
Pega `cloud-init/user-data.yaml` en **Create instance → Advanced → User data** para que la VM arranque lista con KDE/VNC, Docker, HA, etc.

---

### 📜 Licencia
MIT License – © 2025 Ray García (Lebov90)

---

## 🇬🇧 English

Infrastructure ready for **Oracle Cloud (OCI) + Fedora** with:

- **KDE + TigerVNC** (display `:1` → port **5901**) for remote desktop  
- **Home Assistant** in **Docker** (or Podman + systemd)  
- **Tailscale** (optional, with SSH enabled)  
- **Plex Media Server** (optional)  
- **AnyDesk** and **RustDesk** (optional, 24/7 remote access)  
- **firewalld** configured to open:
  - **22** (SSH)  
  - **5901** (VNC)  
  - **8123** (Home Assistant)  
  - **32400** (Plex)  
  - **6568 TCP/UDP** (AnyDesk)  
  - **21111–21112 TCP** (RustDesk)  

> Compatible with Fedora 39+ (tested on 40, 41, and 42).

---

### 🚀 Quick Installation

```bash
sudo dnf -y install git
git clone https://github.com/Lebov90/oracle-fedora-ha-starter.git
cd oracle-fedora-ha-starter
cp .env.example .env   # adjust TZ, VNC_USER, VNC_PASS, TS_AUTHKEY, HA_DATA
chmod +x scripts/*.sh

# Bootstrap + firewall + KDE/VNC + HA in Docker
sudo ./scripts/bootstrap-fedora-oci.sh
sudo ./scripts/open-firewall.sh
sudo ./scripts/install-vnc-kde.sh
sudo ./scripts/install-homeassistant-docker.sh

# Optional
sudo ./scripts/install-tailscale.sh
sudo ./scripts/install-plex.sh
sudo ./scripts/install-anydesk.sh
sudo ./scripts/install-rustdesk.sh
```

---

### 🖥️ Connect to KDE desktop via VNC
1. VNC client → Connect to `PUBLIC_IP:5901`  
2. User/password as configured in `.env` (`VNC_USER`, `VNC_PASS`)  
3. First run: if `VNC_PASS` is empty, you'll be prompted (`vncpasswd`).

---

### 🌐 Ports (also open in OCI Security Lists / NSG)

| Service         | Port(s)   | Protocol |
|-----------------|-----------|----------|
| SSH             | 22        | TCP      |
| VNC             | 5901      | TCP      |
| Home Assistant  | 8123      | TCP      |
| Plex            | 32400     | TCP      |
| AnyDesk         | 6568      | TCP/UDP  |
| RustDesk        | 21111–21112 | TCP    |

---

### ⚙️ `.env` Variables

```env
TZ=America/New_York
DISABLE_SELINUX=0
VNC_USER=
VNC_PASS=
TS_AUTHKEY=
HA_DATA=/opt/homeassistant
```

---

### 📦 Docker Compose (optional for Home Assistant)
```yaml
services:
  homeassistant:
    image: ghcr.io/home-assistant/home-assistant:stable
    container_name: homeassistant
    network_mode: host
    restart: unless-stopped
    environment:
      - TZ=${TZ:-America/New_York}
    volumes:
      - ${HA_DATA:-/opt/homeassistant}:/config
```

---

### 🤖 Using with Codex (ChatGPT)
1. **Configure repository access** → grant access to `Lebov90/oracle-fedora-ha-starter`  
2. Select the repo in Codex  
3. Codex runs `codex/setup.sh` to install everything

---

### ☁️ Cloud-init for OCI (automatic install)
Paste `cloud-init/user-data.yaml` into **Create instance → Advanced → User data** so the VM boots ready with KDE/VNC, Docker, HA, etc.

---

### 📜 License
MIT License – © 2025 Ray García (Lebov90)
