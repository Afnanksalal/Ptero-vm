# PteroVM

we are soo back.

root inside the container the panel already gave you. one jar this time. java only. upload it as `server.jar` and start it like you would any other jar.

## ✨ Features

- root, inside the docker container
- a real desktop on the port wings already assigned you (noVNC)
- fluxbox, xterm, midnight commander, nano, htop
- proot and a small alpine system baked into the jar, so you are not hunting for a second download
- x86_64, arm64, and riscv64. 32-bit arm is not in the jar
- prints `PteroVM ready` plus the link when it is up
- idk what else you want, the desktop was the missing part

## 💁‍♀️ How to use

renting a slot:

- make a java server
- grab the jar for that machine, not all of them: [x86_64](https://github.com/Afnanksalal/Ptero-vm/releases/tag/v2.1-x86_64), [arm64](https://github.com/Afnanksalal/Ptero-vm/releases/tag/v2.1-aarch64), [riscv64](https://github.com/Afnanksalal/Ptero-vm/releases/tag/v2.1-riscv64)
- upload it as `server.jar` (file manager or sftp, same as before)
- startup stays `java -jar server.jar`
- start it
- you're done. the console prints the desktop link and the password

you run the panel:

- import [`egg-pterovm.json`](egg-pterovm.json)
- images are the java 17, 21, and 11 yolks
- it watches for `PteroVM ready` and the stop command is `stop`
- leave the download url blank if the jar is already in the files. set it if you want install to fetch the jar

three jars, one per arch. x86_64, arm64, riscv64. don't grab the wrong one, it will just refuse to unpack. the egg yolks are the normal java ones, so x86_64 and arm64 nodes are covered. a riscv node still needs a riscv java image. if the jar isn't uploaded yet and the download url is blank, install fetches the one that matches the node.

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

v2 is the one jar, the desktop, and the egg. v2.1 splits that jar per arch so you are not downloading the other two.

## ✨ Credits

- Triassic - Made PteroVM Jar

- Chirag - Rewrote PteroVM

- Io.Netty - Original Idea of PteroVM

- Me - For making PteroVM lol

## ✨ Note

please use a host with at least 3GB disk or the unpack will mess up. the jar itself is about 152MB and the system it unpacks is about 425MB, so 3GB still leaves you room.

want to build it yourself? `build.sh` on linux. it pulls proot and alpine and spits out `pterovm-x86_64.jar`, `pterovm-aarch64.jar`, and `pterovm-riscv64.jar`. cross builds need qemu-user-static.

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
