#!/bin/bash
#Definitions
dst=/usr/local/bin/sweet-dns
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
    else
        read < /dev/tty -p $'\033[1m\e[31mWarn >>>\e[0m\033[0m'" dnsmasq already installed! do you want reinstall? [Y/n] " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then brew reinstall dnsmasq; fi
    fi
    if [[ ! -f /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist ]]; then sudo cp -v $(brew --prefix dnsmasq)/homebrew.mxcl.dnsmasq.plist /Library/LaunchDaemons; fi
    if ! sudo launchctl list | grep dnsmasq > /dev/null; then sudo launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist; fi
    which sweet-dns > /dev/null
    if [[ $? -eq 1 ]]; then
        echo -e "\033[1mInfo >>>\033[0m Running sweet-dns installation..."
        curl -L https://git.io/fj9Jz -o $dst -s > /dev/null
        chmod +x $dst
        echo -e "\033[1mInfo >>>\033[0m Installation successfull! \n
        For help use \033[1msweet-dns -h\033[0m \n "
    else
        curl -L https://git.io/fj9Jz -o $tmpdst -s > /dev/null
        if cmp $tmpdst $dst > /dev/null; then
            echo -e "\033[1mInfo >>>\033[0m sweet-dns already installed on your system and up to date! \n
        For help use \033[1msweet-dns -h\033[0m \n "
        else
            echo -e "\033[1mInfo >>>\033[0m Updating sweet-dns installation..."
            cp $tmpdst $dst
            echo -e "\033[1mInfo >>>\033[0m Update successfull! \n
        For help use \033[1msweet-dns -h\033[0m \n "
        fi
        rm $tmpdst
    fi
    exit 0
fi
