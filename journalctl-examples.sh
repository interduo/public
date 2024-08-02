# show logs from 5 minutes
journalctl -u lqosd --since="5 min ago"

# clean logs older than 5 minutes
journalctl --vacuum-time=5min
