## Replace bad drive in system rpool #proxmox #zfs #gpt
zpool offline rpool /dev/disk/by-id/baddrive-serialhere;

# Replicate partition layout from $source to $dest
sgdisk --replicate=/dev/disk/by-id/newdiskreplaced-serialhere /dev/disk/by-id/otherdiskfromrpoolmirror-serialhere

# regenerate GUID for newly inserted drive
sgdisk -G /dev/disk/by-id/newdiskreplaced-serialhere
###END of this stage

#replace broken drive in zfs pool
zpool replace rpool /dev/disk/by-id/baddrive-serialhere /dev/disk/by-id/otherdiskfromrpoolmirror-serialhere-part3

#After resilvering process completed - make second drive bootable (if its system drive)
proxmox-boot-tool format /dev/disk/by-id/otherdiskfromrpoolmirror-serialhere-part2
proxmox-boot-tool init /dev/disk/by-id/otherdiskfromrpoolmirror-serialhere-part2

#clean /etc/kernel/proxmox-boot-uuids and remove from command warning above
proxmox-boot-tool refresh
