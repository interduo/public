#Repair Debian/LXC/SSHD issue with ssh config where it goes back to port 22 after reboot

systemctl mask ssh.socket
systemctl mask sshd.socket

systemctl disable sshd
systemctl enable ssh
