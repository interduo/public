#Repair Debian/LXC/SSHD issue with ssh config where it goes back to port 22 after reboot

1. Firstly try:
sed -i "s/#Port 22/Port 12345/" /etc/ssh/sshd_config
sed -i "s/ListenStream=22/ListenStream=12345/" /etc/systemd/system/sockets.target.wants/ssh.socket

2. Secondly try
systemctl mask ssh.socket
systemctl mask sshd.socket
systemctl disable sshd
systemctl enable ssh
