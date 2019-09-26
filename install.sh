#!/bin/bash
#
# sweet-dns install utility
#
# Definitions
optdir=/usr/local/opt/sweet-dns
dstdir=/usr/local/bin/sweet-dns
tmpzip=/private/tmp/sweet-dns-master.zip
tmpdst=/private/tmp/sweet-dns
#Main
echo -e "\033[1mInfo >>>\033[0m Running sweet-dns installation..."
which brew > /dev/null
if [[ $? -eq 1 ]]; then
    echo -e "\033[1m\e[31mWarn >>>\e[0m\033[0m Homebrew must be installed, refer to https://brew.sh/ \n"
    exit 1
else
    brew ls --versions dnsmasq > /dev/null
    if [[ $? -eq 1 ]]; then
        echo -e "\033[1mInfo >>>\033[0m Running dnsmasq installation..."
        HOMEBREW_NO_AUTO_UPDATE=1 brew install dnsmasq
    fi
    which sweet-dns > /dev/null
    if [[ $? -eq 1 ]]; then
        echo -e "\033[1mInfo >>>\033[0m Running sweet-dns installation..."
        wget -O $tmpzip https://github.com/asiellb/sweet-dns/archive/master.zip
        unzip -joq $tmpzip 'sweet-dns-master/*' -d $optdir/sweet-dns/
        ln -s $optdir/bin/sweet-dns $dstdir
        chmod +x $dstdir
        message="\033[1mInfo >>>\033[0m Installation successfull! \n
        For help use \033[1msweet-dns -h\033[0m \n "
    else
        curl -L https://git.io/fj9Jz -o $tmpdst -s > /dev/null
        if cmp $tmpdst $dstdir > /dev/null; then
            message="\033[1mInfo >>>\033[0m sweet-dns already installed on your system and up to date! \n
            For help use \033[1msweet-dns -h\033[0m \n "
        else
            echo -e "\033[1mInfo >>>\033[0m Updating sweet-dns installation..."
            if [[ $(grep "Version:" $tmpdst | awk '{print $3}') == $(grep "Version:" $dstdir | awk '{print $3}') ]]; then
                cp -rf $tmpdst $optdir/bin/sweet-dns
                chmod +x $dstdir
                message="\033[1mInfo >>>\033[0m Partial update successfull! \n
                For help use \033[1msweet-dns -h\033[0m \n "
            else
                wget -O $tmpzip https://github.com/asiellb/sweet-dns/archive/master.zip
                unzip -joq $tmpzip 'sweet-dns-master/*' -d $optdir/sweet-dns/
                ln -s $optdir/bin/sweet-dns $dstdir
                chmod +x $dstdir
                message="\033[1mInfo >>>\033[0m Full update successfull! \n
                For help use \033[1msweet-dns -h\033[0m \n "
            fi

        fi
        rm -f $tmpdst
        rm -f $tmpzip
    fi
    bash -x sweet-dns -c
    if [[ $? -eq 0 ]]; then
        echo -e $message
        exit 0
    else
        message="\033[1mInfo >>>\033[0m Update not complete :(! \n
                For help use \033[1msweet-dns -h\033[0m \n "
        echo -e $message
        exit 1
    fi
fi
