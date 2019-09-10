#!/bin/bash

echo
echo "Creating different powerdns configuration files..."
sed -i 's~# include-dir=~include-dir=/etc/pdns-recursor/conf.d~g' /etc/pdns-recursor/recursor.conf

mkdir /etc/pdns-recursor/conf.d
cat <<EOF > /etc/pdns-recursor/conf.d/docker.conf

forward-zones-recurse=.=${WILDCARD_FORWARDERS}
forward-zones-file=/etc/pdns-recursor/forward.zone
local-address=0.0.0.0
dont-query=

EOF

echo
echo "Creating forward.zone..."
echo "### Local forwards:" >> /etc/pdns-recursor/forward.zone
for Domain in ${DOMAINS}
do
  echo "${Domain}=${DOMAINS_FORWARDER}:53" >> /etc/pdns-recursor/forward.zone
done 

echo
echo "Config files:"
find /etc/pdns-recursor/

echo "Forward zone:"
cat /etc/pdns-recursor/forward.zone

echo
echo "Deployment done!"
exec "$@"
