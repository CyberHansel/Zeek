#!/bin/bash
# List all packages to be installed
packages=(
  libpcre3
  libpcre3-dbg
  libpcre3-dev
  build-essential
  libpcap-dev
  libnet1-dev
  libyaml-0-2
  libyaml-dev
  pkg-config
  zlib1g
  zlib1g-dev
  libcap-ng-dev
  libcap-ng0
  make
  libmagic-dev
  libnss3-dev
  libgeoip-dev
  liblua5.1-dev
  libhiredis-dev
  libevent-dev
  python-yaml
  rustc
  cargo
)
# Install all packages using apt-get
apt-get update && apt-get install -y "${packages[@]}"
ret=$?
# Check if the installation was successful
if [ $ret -eq 0 ]; then
  echo "Recomended packages installed successfully"
else
  echo "Failed to install the following Recomended packages:"
  for package in "${packages[@]}"; do
    if ! dpkg -s "$package" >/dev/null 2>&1; then
      echo "- $package"
    fi
  done
fi
# Install for iptables/nftables IPS integration
packages2=(
  libnetfilter-queue-dev
  libnetfilter-queue1
  libnetfilter-log-dev
  libnetfilter-log1
  libnfnetlink-dev
  libnfnetlink0
)
apt-get update && apt-get install -y "${packages2[@]}"
ret=$?
# Check if the installation was successful
if [ $ret -eq 0 ]; then
  echo "Iptables set of packages installed successfully"
else
  echo "Failed to install the following Iptables packages:"
  for package in "${packages2[@]}"; do
    if ! dpkg -s "$package" >/dev/null 2>&1; then
      echo "- $package"
    fi
  done
fi
#Installing Suricata
sudo add-apt-repository ppa:oisf/suricata-stable
sudo apt-get update
sudo apt-get install suricata

if [ $? -eq 0 ]; then
    echo "Suricata was installed successfully."
else
    echo "Suricata installation failed."
fi

##############################################
### Edit /etc/suricata/suricata.yaml #########
##############################################

#!/bin/bash

sed -i 's/HOME_NET: "\[192\.168\.0\.0\/16,10\.0\.0\.0\/8,172\.16\.0\.0\/12\]"/HOME_NET: "\[192.168.1.103\/24\]"/g' /etc/suricata/suricata.yaml
































