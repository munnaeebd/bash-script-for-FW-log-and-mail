#!/bin/bash

LOGFILE="/var/log/fw-quarantine/fw-quarantine-$(date +"%d-%m-%Y-%H-%M").log";

/root/fw.sh | grep IPS >> "$LOGFILE";
sleep 5
quarantine_own=$(cat $LOGFILE | grep IPS | grep '118.67\|103.248\|163.53\|36.255' | wc -l );
quarantine_file=$(cat $LOGFILE | grep IPS | wc -l);

EMAIL_MSG="Dear Team\n\nPlease see the log file attached.\n\nNumber of quarantine IP is: $quarantine_file\nTotal InterCloud own IP is: $quarantine_own";

if [ "$quarantine_own" -ne "0" ]
then
 echo -e "$EMAIL_MSG"|mail -a "$LOGFILE" -s "Firewall Quarantine Log || $(date +"%d-%m-%Y-%H-%M")" -r "firewall-log@test-bed.brilliant.com.bd" "cloud.operation@brilliant.com.bd";
fi
exit 0
