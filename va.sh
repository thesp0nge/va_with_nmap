#!/bin/sh

# This is a wrapper around nmap to use it in a lightweight vulnerability
# assessment using vulnscan engine.
# vulnscan is available at http://www.computec.ch/projekte/vulscan/?s=download

# Changelog
#
# v1.0 - 20150724
#   * First release

APPNAME=`basename $0`
VERSION="1.0"

NMAP=`which nmap`
NMAP_OPTS="-sV --script=vulscan/vulscan.nse -oA"

CURL=`which curl`


# Eventually you can play more aggressively
# NMAP_OPTS="-A -T4"

NMAP_SCRIPTS="/usr/local/share/scripts"
VULSCAN_ROOT="$NMAP_SCRIPTS/vulscan"

VULSCAN_URL="http://www.computec.ch/projekte/vulscan/download/nmap_nse_vulscan-2.0.tar.gz"


function is_vulscan_installed {
  if [ -e $VULSCAN_ROOT ]; then
    return 0
  else
    return 1
  fi
}

function install_vulscan {
  $CURL $VULSCAN_URL -o /tmp/nmap_nse_vulscan-2.0.tar.gz
  tar xfvz /tmp/nmap_nse_vulscan-2.0.tar.gz
  echo "Asking root password to install"
  sudo -v
}

##
# Let the story begins...

if ! [ -x $CURL ]; then
  echo "[!] curl is not installed. Giving up"
  exit -1
fi

if ! is_vulscan_installed; then
  echo "Vulscan NMAP engine not found in $VULSCAN_ROOT"

fi

