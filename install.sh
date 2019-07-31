#!/bin/bash
# Set script debug
# set -x
DST=/usr/local/bin/sweet-dns
##Check dependencies
which brew > /dev/null
if [[ $? -eq 1 ]]; then
    echo "Homebrew must be installed, refer to https://brew.sh/"
    exit 1
else
    which dnsmasq > /dev/null
    if [[ $? -eq 1 ]]; then
        echo -e "\033[1minfo >>> \033[0m Running dnsmasq installation..."
        HOMEBREW_NO_AUTO_UPDATE=1 brew install dnsmasq
    fi
    if [[ ! -f /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist ]]; then
        sudo cp -v $(brew --prefix dnsmasq)/homebrew.mxcl.dnsmasq.plist /Library/LaunchDaemons
    fi
    # output=$(sudo launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist)
    which sweet-dns > /dev/null
    if [[ $? -eq 1 ]]; then
        echo -e "\033[1minfo >>> \033[0m Running sweet-dns installation..."
        curl -L https://git.io/fj9Jz -o $DST -s
        chmod +x $DST
        echo -e "\033[1minfo >>> \033[0m Installation successfull! \n
        For help use \033[1msweet-dns -h\033[0m \n "
        exit 0
    else
        echo -e "\033[1minfo >>> \033[0msweet-dns already installed on your system! \n
        For help use \033[1msweet-dns -h\033[0m \n "
        exit 1
    fi
fi
