#!/bin/bash

read -p  "Enter IP address :-" ip_address

if [[ $ip_address =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]
then
        IFS='.' read -r -a octets <<< "$ip_address"

        valid=true

        for octet in "${octets[@]}"
        do
                if (( octet >= 0 && octet > 256 ))
                then
                        valid=false

                        break

                fi
        done
fi

if $valid

then
        read -p "Enter the username :-" user_name

        ssh "$user_name@$ip_address" 'bash -s' << 'EOF'

if [ -d "/usr/lib/Seqrite" ]
then

if systemctl is-active qhclagnt.service > /dev/null

then
        echo "Antiviours is Installed and running"
else
        echo "Antiviours is Directory found but it not install"
fi

else
        echo "Antiviours is not Installed"
fi
EOF

else
        Echo "Invalid IP Address."
fi
