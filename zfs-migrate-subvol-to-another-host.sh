#!/bin/bash
# example1: replicate single pool/subvol/zvol using SSH to remote host
zfs snapshot zfs1-vps1/subvol-103-disk-0@migracja
zfs send zfs1-vps1/subvol-103-disk-0@migracja | ssh root@10.100.0.4 zfs recv zfs1-vps1/subvol-103-disk-0@migracja
#stop maszyny wirtualnej/kontenera
zfs snapshot zfs1-vps1/subvol-103-disk-0@migracja2
zfs send -R -I zfs1-vps1/subvol-103-disk-0@migracja zfs1-vps1/subvol-103-disk-0@migracja2 | ssh root@10.100.0.4 zfs recv zfs1-vps1
#podmiana storage w konfigu, start maszyny

# example2: mass replication whole rpool using SSH to remote host

# Setup/variables:
snapshot_string=DO_NOT_DELETE_
timestamp=`date +%Y%m%d%H%M%S`
source_pool='zfs-pbs1'
destination_pool='zfs-pbs1'
new_snap="$source_pool"@"$snapshot_string""$timestamp"
destination_host='172.20.3.14'

# Initial send:
# Create first recursive snapshot of the whole pool.
zfs snapshot -r "$new_snap"

# Initial replication via SSH.
zfs send -R "$new_snap" | ssh "root@${destination_host}" zfs recv -Fdu "$destination_pool"

# Get old snapshot name.
old_snap=$(zfs list -H -o name -t snapshot -r "$source_pool" | grep "$source_pool"@"$snapshot_string" | tail --lines=1)

# Create new recursive snapshot of the whole pool (with new timestamp).
timestamp=`date +%Y%m%d%H%M%S`
new_snap="$source_pool"@"$snapshot_string""$timestamp"
zfs snapshot -r "$new_snap"

# Incremental replication via SSH.
zfs send -R -I "$old_snap" "$new_snap" | ssh "$destination_host" zfs recv -Fdu "$destination_pool"

# Delete older snaps on the local source (grep -v inverts the selection)
delete_from=$(zfs list -H -o name -t snapshot -r "$source_pool" | grep "$snapshot_string" | grep -v "$timestamp")

for snap in $delete_from;
do
  echo 'run this from console after propper replication'
  echo zfs destroy "$snap"
done
