dd if=/dev/mmcblk0 bs=16M conv=sparse iflag=fullblock status=progress | zstd -T0 -3 | ssh someuser@192.168.0.1 'cat > /home/jkl/baremachine-backup.img.zst'
