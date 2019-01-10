#kickstart configuration file
system-config-kickstart
ksvalidator
vi kickstart.cfg

#kickstart.conf
cat /root/anaconda-ks.cfg > kickstart.cfg

#vmlinuz add the following:
ks=https://serverx/kickstart.cfg


#version=7
# use network isntallation
#sprcify the installatiuon source
url --url="http://serverx/kickstart.cfg"
url --url="http://classroom.example.com/content/rhel7.0/x86_64/dvd/"

ignoredisk --only-use=vda
clearpart

# Clear the Master Boot Record
zerombr
# Partition clearing information
clearpart --all --initlabel
# Disk partitioning information
part / --fstype="xfs" --ondisk=vda --size=5120

network  --bootproto=dhcp
firewall --disabled --service=ssh

lang en_US.UTF-8
ketboard --vckeymap=us --xlayouts='us','us'
timezone Asia/Hong_Kong --isUtc
firstboot --disabled
logging --level=low

%packages
@core
@core
chrony
dracut-config-generic
dracut-norescue
firewalld
grub2
kernel
rsync
tar
httpd
-plymouth

%post --erroronfail
# make sure firstboot doesn't start
echo "RUN_FIRSTBOOT=NO" > /etc/sysconfig/firstboot
# append /etc/issue with a custom message
echo "Kickstarted for class on $(date)" >> /etc/issue
%end

rootpw --plaintext redhat

#configure SSH to permit root login
SSHD_CONFIG=/etc/ssh/SSHD_CONFIG
if grep -q '^PermitRootLogin' ${SSHD_CONFIG}

#prescript
%pre
#postscript
%post

ksvalidator kickstart.cfg

pubish the config file on web
cp ~/kickstart.cfg /var/www/html

curl https://serverx/kickstart.cfg
