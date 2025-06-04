############################################################################################
# Auther :-Deepak Prajapati
# Created Date :- 04/06/2025
# Virsion :- v1
#############################################################################################

# This script use to check commvault agent is install and running on  linux Servers

#!/bin/bash

file_name=/root/IP-Address_list.txt   ### List of ip Address 

#read -p  "Enter IP address :-" ip_address

for ip_address in $( cat $file_name )
do
if [[ $ip_address =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]  #### This condition is use to check the value taken from IP-Address_list.txt file is vaild ip or not
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
	echo "###############################################################################"

	echo "Login to $ip_address server." 	
	
	echo "###############################################################################"
	
	echo " "

	read -p "Enter the username :-" user_name              ### ask user name for login
	
	echo " "
	
#	ssh-keyscan -H "$ip_address" >> ~/.ssh/known_hosts 2>/dev/null     #### Add the server identity to host
	
        ssh "$user_name@$ip_address" 'bash -s' << 'EOF'   ### using EOF we pass the condition to server to check the Commvault Agent service and the file path 

if [ -d "/opt/commvault/Base" ]
	then

	if systemctl is-active commvault.service  > /dev/null

	then

	echo " "
        echo "Commvault Agent is Installed and running"
else
        echo " Commvault Agent Directory found but it not install"
fi

else
	echo " "
        echo "Commvault Agent is not Installed"
fi
EOF

	echo " "

else
        Echo "Invalid IP Address."
fi

done
