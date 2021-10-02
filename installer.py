import subprocess

subprocess.call("echo Thanks for using Ptero-VM!", shell=True) 
subprocess.call("curl -o installer.sh https://raw.githubusercontent.com/afnan007a/Ptero-vm/main/installer.sh", shell=True) 
subprocess.call("chmod +x installer.sh", shell=True) 
subprocess.call("./installer.sh", shell=True) 
