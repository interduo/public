#ustawiamy aktywny serwer PBS
export PBS_REPOSITORY=pbs1:store1

#lista kopii zapasowych
proxmox-backup-client snapshot list vm/103

#montowańsko pliku zrzutu dysku
proxmox-backup-client map vm/103/2025-02-01T15:00:08Z drive-virtio1.img

#montowanie systemu pliku podspodem (akurat tutaj ext3)
mount /dev/loop0 /mnt/test123/ -o noload

#czyścimy
umount /mnt/test123
proxmox-backup-client unmap /dev/loop0
losetup -d /dev/loop0
