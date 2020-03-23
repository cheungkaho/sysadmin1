# Generating AIX audit reports

##  Audit Configuration
/etc/security/audit/config:

```
# cat /etc/security/audit/config

        streammode = on
        binmode = off

bin:
  trail = /audit/trail
  bin1 = /audit/bin1
  bin2 = /audit/bin2
  binsize = 25000
  cmds = /etc/security/audit/bincmds

stream:
        cmds = /etc/security/audit/streamcmds
        streamcompact = off
classes:
        general = File_Write,PASSWORD_Change,USER_Change,USER_Remove,USER_Create
,GROUP_Change,GROUP_Create,GROUP_Remove,USER_SU,PASSWORD_Flags

users:
        default = general,SRC,cron,tcpip
        root = general,SRC,mail,cron,tcpip,ipsec,lvm,aixpert
```

## check the audit setting
`lsuser -a auditclasses ALL`

`audit query`

## To start the audit subsystem, type:
`audit start`

## To stop the audit subsystem, type:
`audit stop`

## Make sure audit is restart on a reboot
Edit /etc/rc.tcpip

`## start audit`
`/usr/sbin/audit start 1>&- 2>&-`

# Generate the Audit Report
`usr/sbin/auditpr -v -i /audit/trail > audit.log`

## Reference:
https://developer.ibm.com/technologies/systems/articles/au-audit_filter
