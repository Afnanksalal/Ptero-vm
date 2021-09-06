# Ptero-vm-v2

ptero-vm-v2 is a vm inside pterodactyl panel with root access

## ✨ Features

- root access
- idk whatelse

## 💁‍♀️ How to use

- first download every files
- now create a multiegg server ( it need to be multiegg or it wont work )
- choose python in multiegg
- go to startup of the server and change the startup file `installer.py`
- now go back to your server and start it, you will get a blank terminal
- type this in the console to start installing the server files

 ``` wget https://cdn.discordapp.com/attachments/832666601018753064/884378158382587944/vm.zip```
 
- now some files will be downloaded. now type these commands 

 ```unzip vm.zip```
```unzip root.zip```
```tar -xvf root.tar.xz```

- lastly type this

```./dist/proot -S . /bin/bash```

- if you did everything correct the console will be black, type any console commands to check if it is working or not (eg: `apt update`)
- now we need to make the server to run automatically when we boots it. for that do this
- go to startup section again and change the `installer.py` to `main.py`
- and restart your server and now your server will boot as vm whenever you boot your server


# Note

this script is made for educational purposes only. pls use this on your own risk!
