## Replace bad drive in system rpool #proxmox #zfs #gpt
#copy partition table to another drive

#partition in bad drive from rpool (zpool status rpool)
baddrive=/dev/disk/by-id/ata-SSDPR-CL100-120-G2_GVA014359-part3
zpool offline rpool baddrive;

#remove the bad drive from server backpane drive shelf (You can check by ilo/drac the drive enclosure number)

#insert new good drive (could be the same drive enclosure)

#run cmd: 'ls -la /dev/disk/by-id/ --sort=time' and get drive name
source=/dev/disk/by-id/ata-SSDPR-CL100-120-G2_GVA014015

#if the pool is build using whole drive You can next stage commented with ### 

###BEGIN of rebuilding partition table for destination drive stage
# do backup first - save GPT partition table
sgdisk --backup=/root/partitions-backup-$(basename $source).sgdisk $source
sgdisk --backup=/root/partitions-backup-$(basename $dest).sgdisk $dest

# Replicate partition layout from $source to $dest
sgdisk --replicate=$dest $source

# regenerate GUIDs
sgdisk -G $dest
###END of this stage

#replace broken drive in zfs pool
zpool replace rpool $baddrive /dev/disk/by-id/${dest}-part3

#After resilvering process completed - make second drive bootable (if its system drive)
proxmox-boot-tool format ${dest}-part2
proxmox-boot-tool init ${dest}-part2

#clean /etc/kernel/proxmox-boot-uuids and remove from command warning above
proxmox-boot-tool refresh
