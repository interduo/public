exit;

#single example
zfs snapshot zfs1-vps1/subvol-103-disk-0@migracja
zfs send zfs1-vps1/subvol-103-disk-0@migracja | ssh root@10.100.0.4 zfs recv zfs1-vps1/subvol-103-disk-0@migracja

#mass example
srcpool='zfs-pbs1'
dstpool='zfs-pbs1'

for i in 'vm-backup'
do
    zfs snap ${srcpool}/${i}@snapshot
    zfs send ${srcpool}/${i}@snapshot | ssh root@172.20.3.14 zfs recv ${dstpool}/${i}"
    zfs destroy ${srcpool}/${i}@snapshot
done
