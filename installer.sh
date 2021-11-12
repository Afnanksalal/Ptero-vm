#!/bin/bash
HOME="/home/container"
HOMEA="$HOME/linux/.apt"
STAR1="$HOMEA/lib:$HOMEA/usr/lib:$HOMEA/var/lib:$HOMEA/usr/lib/x86_64-linux-gnu:$HOMEA/lib/x86_64-linux-gnu:$HOMEA/lib:$HOMEA/usr/lib/sudo"
STAR2="$HOMEA/usr/include/x86_64-linux-gnu:$HOMEA/usr/include/x86_64-linux-gnu/bits:$HOMEA/usr/include/x86_64-linux-gnu/gnu"
STAR3="$HOMEA/usr/share/lintian/overrides/:$HOMEA/usr/src/glibc/debian/:$HOMEA/usr/src/glibc/debian/debhelper.in:$HOMEA/usr/lib/mono"
STAR4="$HOMEA/usr/src/glibc/debian/control.in:$HOMEA/usr/lib/x86_64-linux-gnu/libcanberra-0.30:$HOMEA/usr/lib/x86_64-linux-gnu/libgtk2.0-0"
STAR5="$HOMEA/usr/lib/x86_64-linux-gnu/gtk-2.0/modules:$HOMEA/usr/lib/x86_64-linux-gnu/gtk-2.0/2.10.0/immodules:$HOMEA/usr/lib/x86_64-linux-gnu/gtk-2.0/2.10.0/printbackends"
STAR6="$HOMEA/usr/lib/x86_64-linux-gnu/samba/:$HOMEA/usr/lib/x86_64-linux-gnu/pulseaudio:$HOMEA/usr/lib/x86_64-linux-gnu/blas:$HOMEA/usr/lib/x86_64-linux-gnu/blis-serial"
STAR7="$HOMEA/usr/lib/x86_64-linux-gnu/blis-openmp:$HOMEA/usr/lib/x86_64-linux-gnu/atlas:$HOMEA/usr/lib/x86_64-linux-gnu/tracker-miners-2.0:$HOMEA/usr/lib/x86_64-linux-gnu/tracker-2.0:$HOMEA/usr/lib/x86_64-linux-gnu/lapack:$HOMEA/usr/lib/x86_64-linux-gnu/gedit"
STARALL="$STAR1:$STAR2:$STAR3:$STAR4:$STAR5:$STAR6:$STAR7"
export LD_LIBRARY_PATH=$STARALL
export PATH="$HOMEA/bin:$HOMEA/usr/bin:$HOMEA/sbin:$HOMEA/usr/sbin:$HOMEA/etc/init.d:$PATH"
export BUILD_DIR=$HOMEA
bold=$(echo -en "\e[1m")
nc=$(echo -en "\e[0m")
lightblue=$(echo -en "\e[94m")
lightgreen=$(echo -en "\e[92m")
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
echo "${nc}"
if [[ -f "./installed" ]]; then
    echo "Started PteroVM"
    function runcmd1 {
        echo "${lightgreen}VM@PteroVM${nc}:${lightblue}~${nc}$"
        read -r cmdtorun
        ./dist/proot -S . /bin/bash -c "$cmdtorun"
        runcmd
    }
    function runcmd {
        echo "${lightgreen}VM@PteroVM${nc}:${lightblue}~${nc}$"
        read -r cmdtorun
        ./dist/proot -S . /bin/bash -c "$cmdtorun"
        runcmd1
    }
    runcmd
else
    echo "Downloading files for PteroVM"
    curl -sSLo ptero-vm.zip https://transfer.sh/get/nvV8qx/ptero-vm.zip
    curl -sSLo apth https://raw.githubusercontent.com/afnan007a/Ptero-vm/main/apth
    curl -sSLo unzip https://raw.githubusercontent.com/afnan007a/Ptero-vm/main/unzip
    curl -sSLo gotty https://raw.githubusercontent.com/afnan007a/Replit-Vm/main/gotty
    chmod +x apth
    echo "Installing the files"
    ./apth unzip curl python3 >/dev/null # redirect stdout to /dev/null, but not stderr
    linux/usr/bin/unzip ptero-vm.zip
    linux/usr/bin/unzip root.zip
    tar -xf root.tar.gz # disable verbose
    chmod +x ./dist/proot
    chmod +x main.sh
    chmod +x gotty
    rm -rf ptero-vm.zip
    rm -rf root.zip
    rm -rf root.tar.gz
    clear
    touch installed
    ./dist/proot -S . /bin/bash -c "curl -o /bin/systemctl https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py"
    ./dist/proot -S . /bin/bash -c "chmod +x /bin/systemctl"
    echo "Started PteroVM"
    function runcmd1 {
        echo "${lightgreen}VM@PteroVM${nc}:${lightblue}~${nc}$"
        read -r cmdtorun
        ./dist/proot -S . /bin/bash -c "$cmdtorun"
        runcmd
    }
    function runcmd {
        echo "${lightgreen}VM@PteroVM${nc}:${lightblue}~${nc}$"
        read -r cmdtorun
        ./dist/proot -S . /bin/bash -c "$cmdtorun"
        runcmd1
    }
    runcmd
fi
