# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
BOX_IMAGE="centos/7"
BOX_VERSION="1905.1"
# BOX_IMAGE="hlesey/docker-base"
NAME="dockerhost"

required_plugins = %w(vagrant-vbguest vagrant-share)

required_plugins.each do |plugin|
  system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "4096", "--cpus", "4", "--ioapic", "on"]
    vb.name = NAME
    second_disk = ".vagrant/machines/" + NAME + "/virtualbox/disk2.vdi"
    unless File.exist?(second_disk)
      vb.customize ['createhd', '--filename', second_disk, '--format', 'VDI', '--size', 10 * 1024]
    end
    vb.customize ['storageattach', :id, '--storagectl', 'IDE', '--port', 0, '--device', 1, '--type', 'hdd', '--medium', second_disk]
  end

  config.vm.synced_folder "../../../../", "/repo/", id: "vagrant-repo",
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
