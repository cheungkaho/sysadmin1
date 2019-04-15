#check the cloning process
 ps -ef |grep -i qemu-img
 cat /proc/33259/fd/1

#shutdown the VM
root@foundationX ~]# virsh list
 Id Name                 State
----------------------------------
 1  desktop              running
 2  server               running

[root@foundationX ~]# virsh destroy server
[root@foundationX ~]# virsh list --all
 Id Name                 State
----------------------------------
 1  desktop              running
 -  server               shut off

[root@foundationX ~]# virsh start server
[root@foundationX ~]# virsh list
 Id Name                 State
----------------------------------
 1  desktop              running
 2  server               running


virsh has subcommands for additional management tasks:
connect—Connect to a local or remote KVM host using qemu:///host syntax.
nodeinfo—Returns basic information about the host, including CPUs and memory.
autostart—Configures a KVM domain to start when the host boots.
console—Connect to the virtual serial console of a guest.
create—Create a domain from an XML configuration file and start it.
define—Create a domain from an XML configuration file, but do not start it.
undefine—Undefine a domain. If the domain is inactive, the domain configuration is removed.
edit—Edit the XML configuration file for a domain, which will affect the next boot of the guest.
reboot—Reboot the domain, as if the reboot command had been run from inside the guest.
shutdown—Gracefully shuts down the domain, as if the shutdown command had been run from inside the guest.
screenshot—Takes a screenshot of a current domain console and stores it in a file.
