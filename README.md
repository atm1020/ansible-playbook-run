### ansible-playbook-run

* This is a simple bash script that allows you to run your local Ansible playbook easily.
* You can run the full playbook or just a specific tag based on your selected playbook.

### Prerequisites
- fzf
- ansible

### Usage
 ```bash 
ansible-playbook-run
```
Select a tag or run the full playbook with the ```all``` option.


![commit_graph](img/demo.gif)

The actual user name is passed as an extra var with the name variable name ```user```,
so you can  use this in your playbook like this ```{{ user }}```

### Installation
You can pass the playbook path as an argument (```-p path-to-the-playbook```) or you will be prompted to enter it.

```bash
bash <(curl -s  https://raw.githubusercontent.com/atm1020/ansible-playbook-run/main/installer.sh)
```
