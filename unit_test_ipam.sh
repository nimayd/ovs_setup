/usr/share/openvswitch/scripts/ovn-ctl start_northd

ovn-nbctl lswitch-add sw0
ovn-nbctl lport-add sw0 p0
ovn-nbctl add Logical-Switch sw0 options subnet=192.168.1.0/24

for n in `seq 1 9`; do
    ovn-nbctl lport-add sw0 "p$n"
done

ovn-nbctl lswitch-add sw1
ovn-nbctl lport-add sw1 p10
ovn-nbctl add Logical-Switch sw1 options subnet=192.168.1.0/24

for n in `seq 11 19`; do
    ovn-nbctl lport-add sw1 "p$n"
done

ovn-nbctl lport-set-addresses p0 "0a:00:00:00:00:15 192.168.1.12 192.168.1.14"
ovn-nbctl lport-add sw0 p20
ovn-nbctl lport-add sw0 p21

ovn-nbctl create Logical_Router name=R1
ovn-nbctl -- --id=@lrp create Logical_Router_port name=sw0 \
network="192.168.1.1/24" mac=\"0a:00:00:00:00:17\" \
-- add Logical_Router R1 ports @lrp -- lport-add sw0 rp-sw0 \
-- set Logical_port rp-sw0 type=router options:router-port=sw0
ovn-nbctl lport-add sw0 p22

ovn-nbctl show -- list Logical-Router-Port
