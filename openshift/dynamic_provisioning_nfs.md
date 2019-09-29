1. Create NFS mount point
pvcreate /dev/sdc
vgcreate datavg
vgcreate datavg /dev/sdc
lvcreate -n datalv -L 60G datavg
mkfs -t xfs /dev/mapper/datavg-datalv
echo "/dev/mapper/datavg-datalv   /exports   xfs     defaults        0 0" >> /etc/fstab
mkdir -p /exports/app
chmod -R 755 /exports

2. Create NFS share
yum install -y nfs-utils rpcbind
cat <<EOF > /etc/exports
/exports/app *(rw,sync,no_root_squash)
/exports/registry *(rw,root_squash)
EOF
setsebool -P virt_use_nfs 1
iptables -I INPUT 1 -p tcp --dport 2049 -j ACCEPT
iptables -I INPUT 1 -p tcp --dport 20048 -j ACCEPT
iptables -I INPUT 1 -p tcp --dport 111 -j ACCEPT
firewall-cmd --permanent --zone=public --add-service=nfs
firewall-cmd --permanent --zone=public --add-service=rpcbind
firewall-cmd --permanent --add-port=2049/tcp
firewall-cmd --permanent --add-port=2049/udp
firewall-cmd --reload
systemctl enable rpcbind
systemctl enable nfs-server
systemctl enable rpcbind
systemctl start rpcbind
systemctl start rpcbindsystemctl start nfs-server
systemctl start nfs-server
firewall-cmd --permanent --zone=public --add-service=rpcbind
showmount -e hommstlp01

3. Download the external-storage-master.zip
wget https://github.com/kubernetes-incubator/external-storage/archive/master.zip
yum install -y unzip
unzip master.zip

4. Create the nfs-provisioner
cd external-storage-master/nfs-client
oc new-project nfs-provisioner
NAMESPACE=`oc project -q`
sed -i'' "s/namespace:.*/namespace: $NAMESPACE/g" ./deploy/rbac.yaml
oc create -f deploy/rbac.yaml
oadm policy add-scc-to-user hostmount-anyuid system:serviceaccount:$NAMESPACE:nfs-client-provisioner

sed -i'' "s/10.10.10.60/hommstlp01/g"  ./deploy/deployment.yaml
sed -i'' "s/\/ifs\/kubernetes/\/exports\/app/g" ./deploy/deployment.yaml
oc create -f deploy/deployment.hommstlp01.yaml
oc create -f deploy/class.yaml

5. Test the Dynamic provisioning
oc create -f deploy/test-claim.yaml -f deploy/test-pod.yaml
ls /exports/app/nfs-provisioning*
oc delete -f deploy/test-pod.yaml -f deploy/test-claim.yaml

