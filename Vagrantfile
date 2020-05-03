# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
BOX_IMAGE="ubuntu/bionic64"
BOX_VERSION="20200429.0.0"
NAME="dockerhost"

required_plugins = %w(vagrant-vbguest vagrant-share)

required_plugins.each do |plugin|
  system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "4096", "--cpus", "4", "--ioapic", "on"]
    vb.name = NAME
  end

  config.vm.synced_folder "../", "/repo/", id: "vagrant-repo",
                          owner: "vagrant",
                          group: "vagrant",
                          mount_option: ["dmode=777,fmode=777"]
						  
  # docker machine
  config.vm.define "dockerhost" do |dockerhost|
    dockerhost.vm.box = BOX_IMAGE
    dockerhost.vm.box_version = BOX_VERSION
    dockerhost.vm.network :private_network, ip:"192.168.100.99"
    dockerhost.vm.network :forwarded_port, guest: 22, host: 22199, id: 'ssh'  
    dockerhost.vm.hostname = 'dockerhost.local'
    dockerhost.vm.provision "shell", path: "src/scripts/initial_setup.sh"

    ### forwarding nexus and docker ports
    dockerhost.vm.network :forwarded_port, guest: 8081, host: 28081, id: 'nexus'
    dockerhost.vm.network :forwarded_port, guest: 8082, host: 28082, id: 'nexus_docker'
  end
end
