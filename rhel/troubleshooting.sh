# Fail to boot the server

#1. boot the server in rescue mode
https://access.redhat.com/articles/3405661#rhel7rescue
chroot /mnt/sysimage

#2. Fail to chroot
https://access.redhat.com/solutions/43133
if there is missing /bin in /mnt/sysimage
ln -s /usr/bin /mnt/sysimage/bin

#3. run the sosreport
sosreport

#4. enable the network and sshd in rescue environment
https://access.redhat.com/solutions/2626631
ip link
ip link set dev eth0 up
ip addr add 192.168.122.250/24 dev eth0
ip route add default via 192.168.122.1

https://superuser.com/questions/688733/start-a-systemd-service-inside-chroot
service --skip-redirect <service> restart

#5. transfer files to somewhere