# userA can execute commands as userB

add file to `/etc/suders.d/usera`
```
User_Alias USERA = usera 
Cmnd_Alias USERA_CMD = command1 , command2
USERA ALL=(userb) NOPASSWD: USERA_CMD
```

# Check the sudoer syntax
` visudo -c `
