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
 
if [[ -f "./main.sh" ]]; then
echo "starting vm"
./main.sh
else 
echo "Downloading files for PteroVM"
curl -o ptero-vm.zip https://fatgrizzly.mehost.us/ptero-vm.zip
curl -o apth https://raw.githubusercontent.com/afnan007a/Ptero-vm/main/apth
curl -o unzip https://raw.githubusercontent.com/afnan007a/Ptero-vm/main/unzip
curl -o gotty https://raw.githubusercontent.com/afnan007a/Replit-Vm/main/gotty
chmod +x apth
echo "Installing the files"
./apth unzip
linux/usr/bin/unzip ptero-vm.zip
linux/usr/bin/unzip root.zip
tar -xvf root.tar.gz
chmod +x ./dist/proot
chmod +x main.sh
chmod +x gotty
echo "Removing unwanted files and packages"
rm -rf ptero-vm.zip
rm -rf root.zip
rm -rf root.tar.gz
echo
echo "Started PteroVM"
./dist/proot -S . /bin/bash                                            
fi
