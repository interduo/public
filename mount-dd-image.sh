# attach image to loopback device
losetup --partscan --find --show disk-dd.img

# check partition schema
fdisk -l /dev/loop0

# mount read-only, dont check journal
mount -o ro,noload /dev/loop0p1 /mnt/dst1

# after work's done do cleanup
umount /mnt/dst1
losetup -D
