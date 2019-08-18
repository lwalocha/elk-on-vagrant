#! /bin/bash

ANSIBLE_HOST_KEY_CHECKING=false ansible -i /vagrant/inventory.yml all -m ping
ansible-playbook -v -i /vagrant/inventory.yml /vagrant/elk.yml
ansible-playbook -v -i /vagrant/inventory.yml /vagrant/kibana.yml
ansible-playbook -v -i /vagrant/inventory.yml /vagrant/beats.yml
ansible-playbook -v -i /vagrant/inventory.yml /vagrant/dashboards.yml

