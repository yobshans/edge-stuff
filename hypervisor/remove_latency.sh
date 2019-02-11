## SPINE-LEAF remove latency

sudo tc qdisc del dev ifb0 root netem delay 100ms limit 15000000
sudo tc qdisc del dev dcn1-data ingress
sudo ip link set dev ifb0 down
sudo tc qdisc del dev dcn1-data root netem delay 100ms limit 15000000

sudo tc qdisc del dev ifb1 root netem delay 100ms limit 15000000
sudo tc qdisc del dev dcn2-data ingress
sudo ip link set dev ifb1 down
sudo tc qdisc del dev dcn2-data root netem delay 100ms limit 15000000

sudo tc qdisc del dev ifb2 root netem delay 100ms limit 15000000
sudo tc qdisc del dev dcn1-management ingress
sudo ip link set dev ifb2 down
sudo tc qdisc del dev dcn1-management root netem delay 100ms limit 15000000

sudo tc qdisc del dev ifb3 root netem delay 100ms limit 15000000
sudo tc qdisc del dev dcn2-management ingress
sudo ip link set dev ifb3 down
sudo modprobe -r ifb
sudo tc qdisc del dev dcn2-management root netem delay 100ms limit 15000000

sudo tc -s qdisc show dev dcn1-data
sudo tc -s qdisc show dev ifb0
sudo tc -s qdisc show dev dcn2-data
sudo tc -s qdisc show dev ifb1
sudo tc -s qdisc show dev dcn1-management
sudo tc -s qdisc show dev ifb2
sudo tc -s qdisc show dev dcn2-management
sudo tc -s qdisc show dev ifb3

