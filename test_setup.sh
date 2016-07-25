/usr/share/openvswitch/scripts/ovn-ctl start_northd

ovn-nbctl lswitch-add sw0
ovn-nbctl lport-add sw0 p0 -- lport-add sw0 p1
ovn-nbctl add Logical-Switch sw0 options subnet=192.168.1.0/24
for n in `seq 2 5`; do
    ovn-nbctl lport-add sw0 "p$n"
done
ovn-nbctl lswitch-add sw1
ovn-nbctl lport-add sw1 p6 -- lport-add sw1 p7
ovn-nbctl add Logical-Switch sw1 options subnet=192.168.1.0/24
ovn-nbctl lport-set-addresses p0 "0a:00:00:00:00:cc 192.168.1.8 192.168.1.9"
ovn-nbctl create Logical_Router name=R1
ovn-nbctl -- --id=@lrp create Logical_Router_port name=sw0 \
network="192.168.1.1/24" mac=\"0a:00:00:00:00:22\" \
-- add Logical_Router R1 ports @lrp -- lport-add sw0 rp-sw0 \
-- set Logical_port rp-sw0 type=router options:router-port=sw0
ovn-nbctl -- --id=@lrp create Logical_Router_port name=sw01 \
network="192.168.1.10/24" mac=\"0a:00:00:00:00:23\" \
-- add Logical_Router R1 ports @lrp -- lport-add sw0 rp-sw01 \
-- set Logical_port rp-sw01 type=router options:router-port=sw01
ovn-nbctl lport-add sw0 p8
ovn-nbctl show -- list Logical-Router-Port
