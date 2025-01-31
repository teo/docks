groupadd -g 980 mesosalien
useradd -u 980 -g 980 mesosalien
groupadd -g 981 mesosci
useradd -u 981 -g 981 mesosci
groupadd -g 982 mesosdaq
useradd -u 982 -g 982 mesosdaq
groupadd -g 983 mesosuser
useradd -u 983 -g 983 mesosuser
groupadd -g 984 mesostest
useradd -u 984 -g 984 mesostest

export DEBIAN_FRONTEND=noninteractive
apt update -y
apt upgrade -y
apt install -y apt-utils
apt install -y build-essential curl libcurl4-gnutls-dev gfortran swig autoconf \
    automake autopoint unzip texinfo gettext libtool libtool-bin pkg-config    \
    libmysqlclient-dev xorg-dev libglu1-mesa-dev libfftw3-dev libxml2-dev flex \
    bison libperl-dev libbz2-dev liblzma-dev libnanomsg-dev lsb-release rsync  \
    linux-headers-5.4.0-53-generic libkmod-dev libpci-dev libmotif-dev         \
    git environment-modules libglfw3-dev libtbb-dev libncurses-dev ruby-full   \
    rubygems-integration python3-dev python3-venv python3-pip rclone
pip3 install --upgrade pip

# Don't generate rdoc or ri documentation.
gem install --document '' fpm

curl -L https://releases.hashicorp.com/vault/0.5.0/vault_0.5.0_linux_amd64.zip -o vault.zip
unzip vault.zip && mv ./vault /usr/bin/vault && rm -f vault.zip

# Ubuntu doesn't install python -> python3 links by default.
cat <<EOF > /usr/local/bin/python
#!/bin/sh
exec /usr/bin/env python3 "$@"
EOF
chmod +x /usr/local/bin/python
cat <<EOF > /usr/local/bin/pip
#!/bin/sh
exec /usr/bin/env pip3 "$@"
EOF
chmod +x /usr/local/bin/pip
