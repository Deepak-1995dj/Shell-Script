##########################################################################################
# Auther :-Deepak Prajapati
# Created Date :- 31/05/2025
# Virsion :- v2
###########################################################################################

# This script use to check antivirus is install and running in Servers

#!/bin/bash

file_name=/root/IP-Address_list.txt   ### List of ip Address 

#read -p  "Enter IP address :-" ip_address

for ip_address in $(( cat $file_name ))
do
if [[ $ip_address =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]  #### This condition is use to check the data taken from IP-Address_list.txt file is vaild ip or not
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
        echo "##########################################################################################"
        
        echo "Login to $ip_address. server ."

        echo "###########################################################################################"
        
        read -p "Enter the username :-" user_name ### ask user name for login

        ssh-keyscan -H "$ip_address" >> ~/.ssh/known_hosts 2>/dev/null ########## Add the server identity to host
        
        echo " "
        ssh "$user_name@$ip_address" 'bash -s' << 'EOF'   ### using EOF we pass the condition to server to check the antivirus service and the file path 

if [ -d "/usr/lib/Seqrite" ]
then

if systemctl is-active qhclagnt.service > /dev/null

then
        echo " "
        echo "Antiviours is Installed and running"
else
        echo " "
        echo "Antiviours is Directory found but it not install"
fi

else       
        echo " "
        echo "Antiviours is not Installed"
fi
EOF

        echo " "
else
        echo " "
        Echo "Invalid IP Address."
fi
done
