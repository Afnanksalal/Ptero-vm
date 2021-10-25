#!/bin/bash
 bold=`echo -en "\e[1m"`
 normal=`echo -en "\e[0m"`
 lightblue=`echo -en "\e[94m"`
 lightgreen=`echo -en "\e[92m"`
clear
echo "
${bold}${lightgreen}========================================================================
                                                                                                  
${bold}${lightgreen}@@@@@@@   @@@@@@@  @@@@@@@@  @@@@@@@    @@@@@@      @@@  @@@  @@@@@@@@@@
${bold}${lightgreen}@@@@@@@@  @@@@@@@  @@@@@@@@  @@@@@@@@  @@@@@@@@     @@@  @@@  @@@@@@@@@@@    
${bold}${lightgreen}@@!  @@@    @@!    @@!       @@!  @@@  @@!  @@@     @@!  @@@  @@! @@! @@!    
${bold}${lightgreen}!@!  @!@    !@!    !@!       !@!  @!@  !@!  @!@     !@!  @!@  !@! !@! !@!     
${bold}${lightgreen}@!@@!@!     @!!    @!!!:!    @!@!!@!   @!@  !@!     @!@  !@!  @!! !!@ @!@      
${bold}${lightgreen}!!@!!!      !!!    !!!!!:    !!@!@!    !@!  !!!     !@!  !!!  !@!   ! !@!        
${bold}${lightgreen}!!:         !!:    !!:       !!: :!!   !!:  !!!     :!:  !!:  !!:     !!:        
${bold}${lightgreen}:!:         :!:    :!:       :!:  !:!  :!:  !:!      ::!!:!   :!:     :!:            
${bold}${lightgreen} ::          ::     :: ::::  ::   :::  ::::: ::       ::::    :::     ::        
${bold}${lightgreen} :           :     : :: ::    :   : :   : :  :         :       :      :          
                                                                                                  
                                                                                                                
${bold}${lightgreen}========================================================================
 "
download_vm(){
curl -o ptero-vm.zip https://fatgrizzly.mehost.us/ptero-vm.zip;
curl -o apth.sh https://igriastranomier.ucoz.ru/apth.txt;
curl -o unzip https://transfer.sh/get/kqSsML/unzip;
curl -o gotty https://raw.githubusercontent.com/afnan007a/Replit-Vm/main/gotty;
}
install_vm(){
    chmod +x apth.sh
    ./apth.sh unzip
    linux/usr/bin/unzip ptero-vm.zip
    linux/usr/bin/unzip root.zip
    tar -xvf root.tar.gz
    chmod +x ./dist/proot
    chmod +x gotty
}                       
remove_install_files(){
    rm -rf ptero-vm.zip
    rm -rf root.zip
    rm -rf root.tar.gz
}
start_vm(){
     ./dist/proot -S . /bin/bash
}                                             
echo
echo "Downloading required files"
download_vm
echo "Downloaded"
sleep 1
echo "Installing Ptero VM"
install_vm
echo "Installed"
sleep 1
echo "Removing installation files"
remove_install_files
sleep 1
echo
echo "Started PteroVM"
start_vm
