# PteroVM

we are soo back.

root inside the container the panel already gave you. one jar this time. java only. upload it as `server.jar` and start it like you would any other jar.

## ✨ Features

- root, inside the docker container
- a real desktop on the port wings already assigned you (noVNC)
- fluxbox, xterm, midnight commander, nano, htop
- proot and a small alpine system baked into the jar, so you are not hunting for a second download
- prints `PteroVM ready` plus the link when it is up
- idk what else you want, the desktop was the missing part

## 💁‍♀️ How to use

renting a slot:

- make a java server
- grab [`pterovm.jar`](https://github.com/Afnanksalal/Ptero-vm/releases/latest) from the v2 release
- upload it as `server.jar` (file manager or sftp, same as before)
- startup stays `java -jar server.jar`
- start it
- you're done. the console prints the desktop link and the password

you run the panel:

- import [`egg-pterovm.json`](egg-pterovm.json)
- images are the java 17, 21, and 11 yolks
- it watches for `PteroVM ready` and the stop command is `stop`
- leave the download url blank if the jar is already in the files. set it if you want install to fetch the jar

x86_64. other arches just quit.

## ✨ What's in the box

- Fluxbox
- Xterm
- Midnight Commander
- Nano
- Htop
- noVNC

v1 had gotty and ngrok in the box. this one doesn't. the browser thing is noVNC on the port you already have. you can still install whatever else you want once you are in.

## ✨ v1 to v2

v1 was `server.py`, `server.js`, and a separate jar, plus gotty and ngrok, and the fat binaries lived in PteroVM-Files. last real update was 2023, then it sat archived.

v2 is the one jar, the desktop, the egg, and git lfs so that second repo can go away.

## ✨ Credits

- Triassic - Made PteroVM Jar

- Chirag - Rewrote PteroVM

- Io.Netty - Original Idea of PteroVM

- Me - For making PteroVM lol

## ✨ Note

please use a host with at least 3GB disk or the unpack will mess up. the jar itself is about 152MB and the system it unpacks is about 425MB, so 3GB still leaves you room.

want to build it yourself? `build.sh` on linux. it pulls proot and alpine and spits out `pterovm.jar`.

## Disclaimer

this is for educational purposes (obviously lol, not like you're gonna abuse it)  
we are NOT responsible for any consequences,  
as stated in the LICENSE:
```
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
