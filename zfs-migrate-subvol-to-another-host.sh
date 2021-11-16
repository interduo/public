exit;

#example
zfs snapshot zfs1-vps1/subvol-103-disk-0@migracja
zfs send zfs1-vps1/subvol-103-disk-0@migracja | ssh root@10.100.0.4 zfs recv zfs1-vps1/subvol-103-disk-0@migracja
