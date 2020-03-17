# 1. Downnload the Package
https://support.hpe.com/hpsc/swd/public/detail?swItemId=MTX_5ab6295f49964f16a699064f29

# 2. install the Package
`rpm -ivh hponcfg-*.rpm`

# 3. get the ilo information
hponcfg -a -w ilo_info.xml

# 4. Create Add-User.xml
```
<RIBCL VERSION="2.0">
  <LOGIN USER_LOGIN="adminname" PASSWORD="password">
  <USER_INFO MODE="write">
    <ADD_USER 
      USER_NAME="user" 
      USER_LOGIN="user" 
      PASSWORD="12345678">
      <ADMIN_PRIV value ="Y"/>
      <REMOTE_CONS_PRIV value ="Y"/>
      <RESET_SERVER_PRIV value ="Y"/>
      <VIRTUAL_MEDIA_PRIV value ="Y"/>
      <CONFIG_ILO_PRIV value="Y"/>
    </ADD_USER>
  </USER_INFO>
  </LOGIN>
</RIBCL>
```
# 4. Run the command
Command:
/sbin/hponcfg -f /tmp/Add-User.xml -l /tmp/Add-User.out
Description:
This is to Add New User Account (user) and Password (12345678) with Admin Privilege to the iLO Configuration and writing the configuration with the user account to /tmp/Add-User.out file.
