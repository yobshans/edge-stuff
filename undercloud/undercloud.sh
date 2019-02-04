## Creating flavors and tagging nodes for leaf networks ##

ROLES="control0 compute0 compute1 compute2"
for ROLE in $ROLES; do openstack flavor create --id auto --ram 4096 --disk 37 --vcpus 1 $ROLE ; done
for ROLE in $ROLES; do openstack flavor set --property "cpu_arch"="x86_64" --property "capabilities:boot_option"="local" --property "capabilities:profile"="$ROLE" --property resources:CUSTOM_BAREMETAL='1' --property resources:DISK_GB='0' --property resources:MEMORY_MB='0' --property resources:VCPU='0' $ROLE ; done


openstack baremetal node set --property capabilities='profile:control0,boot_option:local' site-controller-0
openstack baremetal node set --property capabilities='profile:control0,boot_option:local' site-controller-1
openstack baremetal node set --property capabilities='profile:control0,boot_option:local' site-controller-2
openstack baremetal node set --property capabilities='profile:compute0,boot_option:local' site-compute-0
openstack baremetal node set --property capabilities='profile:compute1,boot_option:local' dcn1-compute-0
openstack baremetal node set --property capabilities='profile:compute2,boot_option:local' dcn2-compute-0


## Mapping bare metal node ports to control plane network segments

for node in `openstack baremetal node list -f value -c Name|grep site`; do echo $node; openstack baremetal port set --physical-network ctlplane `openstack baremetal port list --node $node -f value -c UUID`; done
for node in `openstack baremetal node list -f value -c Name|grep dcn1`; do echo $node; openstack baremetal port set --physical-network leaf1 `openstack baremetal port list --node $node -f value -c UUID`; done
for node in `openstack baremetal node list -f value -c Name|grep dcn2`; do echo $node; openstack baremetal port set --physical-network leaf2 `openstack baremetal port list --node $node -f value -c UUID`; done

# nodes are in available state
openstack overcloud node provide --all-manageable

