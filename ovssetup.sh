#!/bin/bash

COMMAND=$1

if [ "$COMMAND" == "conf" ]
then
    apt-get -y install autoconf libtool sparse openssl pkg-config make gcc libssl-dev debhelper dh-autoreconf
    aptitude install python-qt4 python-qt4-dev pyqt-tools
    apt-get -y install git-email libmail-sendmail-perl libmailtools-perl
    ./boot.sh
    ./configure --prefix=/usr --localstatedir=/var --sysconfdir=/etc --enable-ssl --enable-Werror --with-linux=/lib/modules/`uname -r`/build

elif [ "$COMMAND" == "make" ]
then
    make -j4
    make install
    make modules_install
    /sbin/modprobe openvswitch
    mkdir -p /etc/openvswitch
    ovsdb-tool create /etc/openvswitch/conf.db vswitchd/vswitch.ovsschema

elif [ "$COMMAND" == "run" ]
then
#    ovsdb-server --remote=punix:/usr/local/var/run/openvswitch/db.sock \
    ovsdb-server --remote=punix:/var/run/openvswitch/db.sock \
                         --remote=db:Open_vSwitch,Open_vSwitch,manager_options \
                         --private-key=db:Open_vSwitch,SSL,private_key \
                         --certificate=db:Open_vSwitch,SSL,certificate \
                         --bootstrap-ca-cert=db:Open_vSwitch,SSL,ca_cert \
                         --pidfile --detach
    ovs-vsctl --no-wait init
    ovs-vswitchd --pidfile --detach --log-file

elif [ "$COMMAND" == "check" ]
then
    make check TESTSUITEFLAGS="-j3"

fi
