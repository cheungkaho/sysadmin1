#show configuration
nmcli -p
cat /etc/sysconfig/network-scripts/ifcfg-eth*
#edit the network adapter
nmcli con add con-name "static-eth0" ifname eth0 type ethernet ip4 172.25.X.11/24 gw4 172.25.X.254
nmcli con mod "static-eth0" ipv4.dns 172.25.254.254
nmcli con mod "static-eth0" +ipv4.dns 8.8.8.8
nmcli con mod con-name "static-eth0" ipv6.method ignore
#nmcli con delete "static-eth0"


#show routing
ip route
cat /etc/sysconfig/network-script/route*

#reload the configuration
nmcli con reload
nmcli con down "static-eth0"
nmcli con up "static-eth0"

#test connection:
ping -c3 172.25.254.254

#DNS
cat /etc/resolv.conf
domain example.com
search example.com
nameserver 172.25.254.254

#set hostname
hostnamectl set-hostname desktopX.example.com

#add IP to the host table
echo "172.25.X.11   `hostname`" >> /etc/hosts
