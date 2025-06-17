# show logs from 5 minutes
journalctl -u lqosd --since="5 min ago"

# show logs since yesterday
journalctl -u lqosd --since yesterday

# clean logs older than 5 minutes
journalctl --vacuum-time=5min

# show journal in reverse order
journalctl --reverse
