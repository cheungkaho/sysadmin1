# 1. Downnload the Package
https://support.hpe.com/hpsc/swd/public/detail?swItemId=MTX_5ab6295f49964f16a699064f29

# 2. install the Package
`rpm -ivh hponcfg-*.rpm`

# 3. Create reset_ilo_password.xml
```
<RIBCL VERSION="2.0">
<LOGIN USER_LOGIN="Administrator" PASSWORD="password">
<USER_INFO MODE="write">
<MOD_USER USER_LOGIN="Administrator">
<PASSWORD value="password specify here only"/>
</MOD_USER>
</USER_INFO>
</LOGIN>
</RIBCL>
```

# 4. Run the hponcfg to reset the password
`hponcfg -f reset_ilo_password.xml`

