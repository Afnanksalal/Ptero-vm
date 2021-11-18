# Ptero-VM

Root-Instance inside of pterodactyl's docker container with Proot.

## ✨ Features

- Root well, inside the docker container.
- idk whatelse

## 💁‍♀️ How to use

- first make a server (js/py/java server)
- then download the `server.py`, `server.jar` or `server.js` file and the `installer.sh`
- then upload the files to your server via file manager or sftp
- then go to startup section of the server and name it `server.py` (if u made python server and downloaded the server.py file) or `server.js` (if u made js server and downloaded the server.js file)  `server.jar` (if u made java server and downloaded the server.jar file)
- now start the server and it will install the files for you and run PteroVM
- you're done

## ✨ Preinstalled Packages

- Python & PIP

- NodeJS & NPM

- Java

- Go

- Htop

- Neofetch

- Nano

- Screen

- Gotty

- Ngrok

- Xmrig

- LolMiner

- Playit

## ✨ Patched bugs

- Systemctl being annoying has been fixed!

## ✨ Addons

 __GoTTY:__
 
 _GoTTY is a simple GoLang based command line tool that enables you to share your terminal(TTY) as a web application. It turns command line tools into web applications._

- to run gotty just type `gotty -p <port> -w bash`in your terminal.

- now it will be up and running, and it will show the ip and port of it in the console. copy paste it in ur browser and there you have remote terminal with gotty

__Xmrig:__
 
 _Xmrig is a CPU crypto mining software which is easy to manage_

- to run Xmrig just type `xmrig -o rx.unmineable.com:3333 -a rx -k -u <coin_here>:<Wallet_address_here>.<worker_name_here> -p x` ie: `xmrig -o rx.unmineable.com:3333 -a rx -k -u SHIB:0xDEcDA3d4bfA4E614A383c17F4E01DD8E0DA9abFE.my_cpu_miner -p x`  in your terminal and continue the steps. if you have any doubts [[Read this docs!]](https://xmrig.com/docs/miner)


__LolMiner:__
 
 _Xmrig is a GPU crypto mining software which is easy to manage_

- to run Xmrig just type `lolminer --algo ETHASH --pool asia-eth.2miners.com:2020 --user <Wallet_address_here>.<worker_name_here> pause ` ie: `lolminer --algo ETHASH --pool asia-eth.2miners.com:2020 --user 0xaa02De1d115d4F6639A1B962C25B1e637Cc9176C.Gpu_Miner pause `  in your terminal and continue the steps. if you have any doubts [[Read this docs!]](https://github.com/Lolliedieb/lolMiner-releases/wiki)

__Playit:__
 
 _Playit is a tunneling software to portforward your server  to custom domains other than the numeric ip_

- to run playit just type `playit` in your terminal and continue the steps. if you have any doubts [[Read this docs!]](https://playit.gg/support/run-on-linux/)

__Ngrok:__
 
 _Ngrok is a tunneling software to portforward your server  to custom domains other than the numeric ip_

- to run ngrok just type `ngrok http <port>` or `ngrok tcp <port>`ie: `ngork tcp 22`  in your terminal and continue the steps. if you have any doubts [[Read this docs!]](https://ngrok.com/docs)

## ✨ Credits

- Triassic - For making PteroVM JAR

- Chirag - For helping me rewrite PteroVM

- Io.Netty - For giving me the idea to make PteroVM

- Me - For making PteroVM lol!

## ✨ Note

**Please use a host which have atleast 3GB disk space or it will messup the installation.**

_this script is configured to only support pterodactyl panel, if u want to make it support something like replit fork it and edit it._

**This script is for educational purposes, we are not responsible for anything that happens.**
