git clone https://github.com/openvswitch/ovs
cp ovssetup.sh ovs
mv ovs ..
cd ../ovs

./ovssetup.sh conf
./ovssetup.sh make
./ovssetup.sh run

cd -
