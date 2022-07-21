#!/bin/bash

# 2/25/2022 Maintainer script 

# Author:  2730246+devsecfranklin@users.noreply.github.com 


#Black        0;30     Dark Gray     1;30
#Red          0;31     Light Red     1;31
#Green        0;32     Light Green   1;32
#Brown/Orange 0;33     Yellow        1;33
#Blue         0;34     Light Blue    1;34
#Purple       0;35     Light Purple  1;35
#Cyan         0;36     Light Cyan    1;36
#Light Gray   0;37     White         1;37

RED='\033[0;31m'
LRED='\033[1;31m'
LGREEN='\033[1;32m'
CYAN='\033[0;36m'
LPURP='\033[1;35m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

MY_OS="unknown"

function detect_os() {
    if [ "$(uname)" == "Darwin" ]
    then
        echo -e "${CYAN}Detected MacOS${NC}"
        MY_OS="mac"
    elif [ -f "/etc/redhat-release" ]
    then
        echo -e "${CYAN}Detected Red Hat/CentoOS/RHEL${NC}"
        MY_OS="rh"
    elif [ "$(grep -Ei 'debian|buntu|mint' /etc/*release)" ]
    then
        echo -e "${CYAN}Detected Debian/Ubuntu/Mint${NC}"
        MY_OS="deb"
    elif grep -q Microsoft /proc/version
    then
        echo -e "${CYAN}Detected Windows pretending to be Linux${NC}"
        MY_OS="win"
    else
        echo -e "${YELLOW}Unrecongnized architecture.${NC}"
        exit 1
    fi
}

function macos() {
  echo -e "${CYAN}Updating brew for MacOS (this may take a while...)${NC}"
  brew cleanup
  brew upgrade
  echo -e "${CYAN}Setting up autools for MacOS (this may take a while...)${NC}"
  #brew install libtool
  brew install gawk
  if [ ! -f "./config.status" ]; then
    echo -e "${CYAN}Running autoconf/automake...${NC}"
    glibtoolize
    aclocal -I config
    if [ -d "aclocal" ]; then
      autoreconf
    else
      autoreconf -i
    fi
    automake -a -c --add-missing
  else
    echo -e "${CYAN}Your system is already configured. (Delete config.status to reconfigure)${NC}"
    ./config.status
  fi
  echo -e "${CYAN}HINT: now type \"./configure\"${NC}"
}

function debian {
  # sudo apt install gnuplot gawk libtool psutils make info

  if [ ! -f "./config.status" ]; then
    # libtoolize
    if [ -d "aclocal" ]; then
      autoreconf
    else
      mkdir aclocal
      aclocal -I config
      autoreconf -i
    fi
    automake -a -c --add-missing
    ./configure
  else
    ./config.status
  fi
}

function redhat() {
  if [ ! -f "./config.status" ]; then
    # libtoolize
    if [ -d "aclocal" ]; then
      autoreconf
    else
      mkdir aclocal
      aclocal -I config
      autoreconf -i
    fi
    automake -a -c --add-missing
    ./configure
  else
    ./config.status
  fi    
}

function main() {
  detect_os
  if [ "${MY_OS}" == "mac" ]; then
    macos
  fi
  if [ "${MY_OS}" == "rh" ]; then
    redhat
  fi
  if [ "${MY_OS}" == "deb" ]; then
    debian
  fi
}

main
