echo " 0 11 2 * * passwd -x -1 kaho" >> /etc/crontab
echo " 1 11 2 * * chage -M 31 kaho" >> /etc/crontab

#crypt password
python -c 'import crypt; print crypt.crypt("test", "$6$random_salt")'
python3 -c 'import crypt; print(crypt.crypt("test", crypt.mksalt(crypt.METHOD_SHA512)))'
openssl passwd -salt <salt> -1 <plaintext>


#playbook to create user
---
- hosts: all
  user: root
  vars:
    # created with:
    # python -c 'import crypt; print crypt.crypt("This is my Password", "$1$SomeSalt$")'
    password: $1$SomeSalt$UqddPX3r4kH3UL5jq5/ZI.

  tasks:
    - user: name=tset password={{password}}
...

create_user.yml:

---
# create_user playbook

- hosts: your_host_group
  become: True
  user: ansible

  roles:
    - create_user
...

roles/create_user/tasks/main.yml:
---
# Generate random password for new_user_name and the new_user_name
# is required to change his/her password on first logon. 

- name: Generate password for new user
  shell: makepasswd --chars=20
  register: user_password

- name: Generate encrypted password
  shell: mkpasswd --method=SHA-512 {{ user_password.stdout }}
  register: encrypted_user_password

- name: Create user account
  user: name={{ new_user_name }}
        password={{ encrypted_user_password.stdout }}
        state=present
        append=yes
        shell="/bin/bash"
        update_password=always
  when: new_user_name is defined and new_user_name in uids
  register: user_created

- name: Force user to change password
  shell: chage -d 0 {{ new_user_name }}
  when: user_created.changed

- name: User created
  debug: msg="Password for {{ new_user_name }} is {{ user_password.stdout }}"
  when: user_created.changed
...

When you want to create a new user:
ansible-playbook -i hosts.ini create_user.yml --extra-vars "new_user_name=kelvin"

The format of /etc/shadow follows (nine colon-separated fields):
1name:2password:3lastchange:4minage:5maxage:6warning:7inactive:8expire:9blank
chage -m 0 -M 90 -W 7 -I 14 username