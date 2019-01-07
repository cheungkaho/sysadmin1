
timedatectl list-timezones |grep -i HongKong
timedatectl set-timezone

timedatectl set-time 

#NTP
systemctl status chronyd
timedatectl set-ntp true

#systemd journal in past 30mins
journalctl --since 9:00:00 --until 9:30:00

#create pv,vg,lv,fs
#old: fdisk /dev/vdb
#p
#n
#t -> 8e
#w
partprobe
pvcreate /dev/vdb
vgcreate datavg /dev/cdb
lvcreate -n datalv -l 80%FREE datavg
mkfs -t xfs /dev/mapper/datavg-datalv
mkdir /data
echo "/dev/mapper/datavg-datalv   /data   xfs  defaults 1 2" >> /etc/fstab
mount -a

#umount /data
#lvremove /dev/mapper/datavg-datalv
#vgremove datavg
#pvremove /dev/vdb

#extend:
pvscan
partprobe
pvresize /dev/vdb
lvextend -L +100G /dev/mapper/datavg-datalv
xfs_growfs /dev/mapper/datavg-datalv

#migrate pv
pvcreate /dev/vdc
vgextend datavg /dev/vdc
vgdisplay datavg
pvmove /dev/vdbc
vgreduce datavg /dev/vdbc



