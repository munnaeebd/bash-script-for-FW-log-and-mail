#!/bin/bash

LOGFILE="/var/log/fw-quarantine/quarantine-IP-$(date +"%d-%m-%Y-%H-%M").txt";

/root/fw.sh | grep IPS >> "$LOGFILE";
sleep 5
quarantine_own=$(cat $LOGFILE | grep IPS | grep '118.67\|103.248\|163.53\|36.255.68\|36.255.69\|36.255.70\|36.255.71' | wc -l );
quarantine_file=$(cat $LOGFILE | grep IPS | wc -l);

IC_LOG_FILE="/var/log/fw-quarantine/InterCloud-quarantine-IP-$(date +"%d-%m-%Y-%H-%M").txt";
cat $LOGFILE | grep IPS | grep '118.67\|103.248\|163.53\|36.255.68\|36.255.69\|36.255.70\|36.255.71' >> "$IC_LOG_FILE";


EMAIL_MSG="Dear Team\n\nPlease see the log file attached.\n\nTotal quarantine IP is: $quarantine_file\nTotal InterCloud own IP is: $quarantine_own";

if [ "$quarantine_own" -ne "0" ]
then
 echo -e "$EMAIL_MSG"|mail -a "$LOGFILE" -a "$IC_LOG_FILE" -s "Firewall Quarantine Log || $(date +"%d-%m-%Y-%H-%M")" -r "firewall-log@test-bed.brilliant.com.bd" "cloud.operation@brilliant.com.bd";
fi
exit 0
