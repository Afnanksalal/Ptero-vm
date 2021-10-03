# Ptero-vm

Root-Instance inside of pterodactyl's docker container with Proot.

## ✨ Features

- Root well, inside the docker container.
- idk whatelse

## 💁‍♀️ How to use

- first make a server (js/py server)
- then Grab the `installer.py` or `installer.js` file
- then go to startup section of the server and name it `installer.py` (if u made python server and downloaded the installer.py file) or `installer.js` (if u made js server and downloaded the installer.js file)
- now start the server and it will install the files for you
- now to make the server run automatically whenever u start it, go to startup and change the startup name to `main.py` (if u made python server and downloaded the installer.py file) or `main.js` (if u made js server and downloaded the installer.js file)
- and restart your server and everything will be fine

## ✨ Bugs/Fixes

__for now there is a bug while booting systemctl i have made a temp fix for it here are the steps:__
- first download python3 and curl ( sudo apt install python3 , sudo apt install curl )
- then download the systemctl file for that execute this command in the terminal ```curl -o systemctl https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py ```
- then chmod the systemctl file (chmod +x systemctl)
- then execute it (```./systemctl start wings``` if u are trying to run a pterodactyl wing inside the vm)

## ✨ Addons

- coming soon!

## ✨ Note

_this script is configured to only support pterodactyl panel, if u want to make it support something like replit fork it and edit it._

**This script is for educational purposes, we are not responsible for anything that happens.**
