require 'rbconfig'
require 'yaml'
cpuCap = 10                                   # Limit to 10% of the cpu
inventory = YAML.load_file("inventory.yml")   # Get the names & ip addresses for the guest hosts
vars = YAML.load_file("group_vars/all.yml")   # Get the global vars info
DEFAULT_BASE_BOX = vars['default_box']
VAGRANTFILE_API_VERSION = '2'
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
#  config.vbguest.auto_update = false
  inventory.each do |group, groupHosts|
#    next if (group == "justLocal")
    groupHosts['hosts'].each do |hostName, hostInfo|
      config.vm.define hostName do |node|
        node.vm.box = hostInfo['box'] ||= DEFAULT_BASE_BOX
        node.vm.hostname = hostName                                       # Set the hostname
        node.vm.network :private_network, ip: hostInfo['ansible_host']    # Set the IP address
        ram = hostInfo['memory']                                          # Set the memory
        node.vm.provider :virtualbox do |vb|
          vb.name = hostName
          vb.customize ["modifyvm", :id, "--memory", ram.to_s]
#          vb.customize ["modifyvm", :id, "--cpuexecutioncap", cpuCap, "--memory", ram.to_s] 
        end
        if (group == "ansible-nodes") then
          node.vm.box = vars['ansible_box']
          node.vm.provision "file", source: "./keys/id_rsa", destination: "$HOME/.ssh/id_rsa"
          node.vm.provision :shell do |shell|
            shell.inline = <<-SHELL
              sudo yum -y install ansible ansible-galaxy
              sudo ansible-galaxy install --roles-path /etc/ansible/roles elastic.elasticsearch
              sudo ansible-galaxy install --roles-path /etc/ansible/roles elastic.beats
              sudo ansible-galaxy install --roles-path /etc/ansible/roles geerlingguy.kibana
            SHELL
          end
        end
        if (group == "es-master-nodes") or (group == "es-data-nodes") then
           node.vm.box = vars['elastic_box']
        end
        if (group == "es-beat-nodes") and (vars['es_use_repository'] == false) then
          node.vm.provision :shell do |shell|
            shell.args = vars['metricbeat_custom_package'] + " " + vars['filebeat_custom_package'] + " " + vars['auditbeat_custom_package']
            shell.inline = <<-SHELL
              sudo yum -y install $1 $2 $3
            SHELL
          end
        end
#        if (group == "esxi-nodes") then
#           node.vm.box = vars['esxi_box']
#           node.vm.provider :virtualbox do |vb|
#             vb.name = hostName
#             vb.customize ["modifyvm", :id, "--usb", "on"]
#             vb.customize ["modifyvm", :id, "--usbehci", "off"]
#           end
#        end
      end
    end
  end
  config.vm.provision :shell, privileged: false do |shell_action|
    ssh_public_key = File.readlines("./keys/id_rsa.pub").first.strip
    shell_action.inline = <<-SHELL
      echo #{ssh_public_key} >> /home/$USER/.ssh/authorized_keys
    SHELL
  end
end
