#!/bin/bash
source /home/stack/stackrc

openstack overcloud deploy \
--timeout 100 \
--templates /usr/share/openstack-tripleo-heat-templates \
-n /home/stack/templates/network_data_spine_leaf.yaml \
-r /home/stack/templates/roles_data_spine_leaf.yaml \
--libvirt-type kvm \
--ntp-server clock.redhat.com \
-e /usr/share/openstack-tripleo-heat-templates/environments/network-isolation.yaml \
-e /home/stack/templates/network-environment.yaml \
-e /home/stack/templates/nodes_data.yaml \
-e /home/stack/docker-images.yaml \
--log-file overcloud_deployment_90.log

