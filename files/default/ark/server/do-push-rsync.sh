#!/bin/sh
# 
# This script limits what the push rsync system can do - current the following commands:
# hostname
# size
# 
# Everything else is considered a rsync 

# extract the remote ip address and confirm that it is in the client list
remote_ip=`echo "$SSH_CLIENT" | awk '{print $1}' `
remote_name=`/bin/grep "ip=$remote_ip\." /home/backup/clients | awk '{print $1}' `

# debugging what we can do
#echo "Command: " "$@" >/tmp/do-push-rsync.log
#echo "remote_ip: " "$remote_ip" >>/tmp/do-push-rsync.log
#echo "remote_name: " "$remote_name" >>/tmp/do-push-rsync.log
#echo "" >>/tmp/do-push-rsync.log
#/usr/bin/printenv >>/tmp/do-push-rsync.log

# deny if IP does not match a known client
label="arkserver_$remote_name"
priority="daemon.info"
if [ "x$remote_name" = "x" ]; then
  remote_name="$remote_ip"
  label="arkserver_$remote_name(unknown)"
  priority="daemon.notice"
fi

#echo "" >>/tmp/do-push-rsync.log
#echo "Starting " `/bin/date` >>/tmp/do-push-rsync.log
case "$SSH_ORIGINAL_COMMAND" in
  hostname)
    hostname
    ;;
  size)
    logger -p "$priority" -t "$label" "Size request"
    /usr/bin/sudo /usr/local/sbin/push-rsync.sh "$remote_name" size
    ;;
  *)
    # presume that we want to do the rsync push
    logger -p "$priority" -t "$label" "Start sync"
    /usr/bin/sudo /usr/local/sbin/push-rsync.sh "$remote_name" 
    logger -p "$priority" -t "$label" "Start sync"
    ;;
esac
#echo "Ending " `/bin/date` >>/tmp/do-push-rsync.log
