DEBIAN13/PROXMOX REPOS

# Debian 13 Trixie
cat > /etc/apt/sources.list.d/debian.list <<'EOF'
deb http://ftp.pl.debian.org/debian trixie main contrib non-free non-free-firmware
deb http://ftp.pl.debian.org/debian trixie-updates main contrib
deb http://security.debian.org/debian-security trixie-security main contrib
EOF

# Proxmox VE 9 - no subscription
cat > /etc/apt/sources.list.d/pve-no-subscription.sources <<'EOF'
Types: deb
URIs: http://download.proxmox.com/debian/pve
Suites: trixie
Components: pve-no-subscription
Signed-By: /usr/share/keyrings/proxmox-archive-keyring.gpg
EOF

# Wyłączenie domyślnych repozytoriów, aby nie było duplikatów
[ -f /etc/apt/sources.list ] && mv /etc/apt/sources.list /etc/apt/sources.list.bak
[ -f /etc/apt/sources.list.d/debian.sources ] && mv /etc/apt/sources.list.d/debian.sources /etc/apt/sources.list.d/debian.sources.disabled
[ -f /etc/apt/sources.list.d/pve-enterprise.sources ] && mv /etc/apt/sources.list.d/pve-enterprise.sources /etc/apt/sources.list.d/pve-enterprise.sources.disabled
[ -f /etc/apt/sources.list.d/pve-enterprise.list ] && mv /etc/apt/sources.list.d/pve-enterprise.list /etc/apt/sources.list.d/pve-enterprise.list.disabled

# Aktualizacja list pakietów
apt update
