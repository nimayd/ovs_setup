git clone https://github.com/openvswitch/ovs
cp ovssetup.sh ovs
mv ovs ..

../ovs/ovssetup.sh conf
../ovs/ovssetup.sh make
../ovs/ovssetup.sh run
