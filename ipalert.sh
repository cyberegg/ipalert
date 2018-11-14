#!/bin/bash

# set some vars
mailfrom=root@host.somewhere.net    # changeme
mailto=root@somewhere.net           # changeme
scriptloc=/home/someuser/ipalert/   # changeme
ipfile=${scrioptloc}current_ip.txt

# source new ip using an opendns query
newip=$(dig +short myip.opendns.com @resolver1.opendns.com)
# if nothing is returned assume we are currently offline
if [ "$newip" = "" ]
then
  exit 0;
fi
oldip="`cat ${ipfile}`"
# if the newly queried ip doesn't match then trigger an email
if [ "$oldip" != "$newip" ]
then
  echo ${newip} > ${ipfile}
  mail -r ${mailfrom} -s "IP Change Detected" ${mailto} < ${ipfile}
fi
