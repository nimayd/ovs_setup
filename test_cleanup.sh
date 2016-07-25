for n in `seq 0 8`; do
    ovn-nbctl lport-del "p$n"
done
ovn-nbctl lswitch-del sw0
ovn-nbctl lswitch-del sw1
ovn-nbctl destroy Logical-Router R1
pkill ovn-northd
