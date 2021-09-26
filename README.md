# Ptero-vm-v2

ptero-vm-v2 is a vm inside pterodactyl panel with root access

## ✨ Features

- root access
- idk whatelse

## 💁‍♀️ How to use

- first download every file from this repo
- create a python server
- go to startup of the server and change the startup file `installer.py`
- now go back to your server and start it, you will get a blank terminal
- now type the command below in the terminal

`curl -o ptero-vm.zip http://fatgrizzly.mehost.us/ptero-vm.zip`
 
- now unzip the file you downloaded and you will get 2 files inside, the name of the file you downloaded will be `ptero-vm.zip`. there will be `root.zip` and `root.tar.gz`. in that unzip the `root.zip` file via file manager in the panel
- now come back to the terminal and unzip the `root.tar.gz` file with the command below

`tar -xvf root.tar.gz`

- wait for it to get finished

- lastly type this in the console

`./dist/proot -S . /bin/bash`

- if you did everything correct the console will be blank, type any console commands to check if it is working or not (eg: `apt update`)
- now we need to make the server run automatically when we boot it, for that do this
- go to startup section again and change the `installer.py` to `main.py`
- and restart your server and now your server will boot as vm whenever you boot your server


# Note

this script is made for educational purposes only. pls use this on your own risk!
