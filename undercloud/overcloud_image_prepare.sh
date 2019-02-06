#!/bin/bash
sudo sed -i 's/^INSECURE_REGISTRY.*/INSECURE_REGISTRY="--insecure-registry 192.168.24.1:8787 --insecure-registry 192.168.24.3:8787 --insecure-registry docker-registry.engineering.redhat.com"/' /etc/sysconfig/docker
sudo service docker restart

source /home/stack/stackrc

openstack overcloud container image prepare --namespace docker-registry.engineering.redhat.com/rhosp13 \
 --tag 2019-01-21.1 \
 --prefix openstack- \
 -e /usr/share/openstack-tripleo-heat-templates/environments/network-isolation.yaml \
 --output-images-file /home/stack/container_images.yaml \
 --output-env-file /home/stack/docker-images.yaml

openstack overcloud container image upload --verbose --config-file /home/stack/container_images.yaml


