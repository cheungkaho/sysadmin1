yum -y install nfs-utils
showmount -e server
mount -t nfs -o sync serverX:/share /mountpoint
echo "serverX:/share  /mountpoint  nfs  sync  0 0" >> /etc/fstab

###krb5  Clients must prove identity using Kerberos and then standard Linux file permissions apply.
systemctl enable nfs-secure
systemctl start nfs-secure

serverX:/shares/public  /mnt/public  nfs  sec=krb5p,sync  0 0
#NFSv4
mount -o sync,sec=sys serverX:/shares/manual /mnt/manual



###autofs
#not need the root privileges
yum install sutofs
#/etc/auto.master.d/public.autofs
/shares  /etc/auto.public
#/etc/auto.master.d/direct.autofs
/~ /etc/auto.direct
#/etc/auto.public
work  -rw,sync  serverX:/shares/work
public   -rw,sec=krb5p,sync  serverX:/shares/public

systemctl enable autofs
systemctl start autofs
#will mount under the /shares directory

#will mount the same name of the source directory
*   -rw,sec=krb5p,sync  serverX:/shares/&



###SMB
yum -y install cifs-utils samba-client

#no password
sudo mount -t cifs -o guest //serverX/share /mountpoint
//serverX/share  /mountpoint  cifs  guest  0 0

#password
mount -t cifs -o credentials=/secure/sherlock //serverX/sherlock /home/sherlock/work

chmod 600 /secure/sherlock
#/secure/sherlock
username=username
password=password
domain=domain