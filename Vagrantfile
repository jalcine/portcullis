# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "quantal64"
  config.vm.box_url = "http://files.vagrantup.com/quantal32.box"

  config.vm.network :forwarded_port, guest: 9292, host: 4373
  config.ssh.forward_agent = true
  config.vm.synced_folder "./", "/var/www/portcullis"

   config.vm.provider :virtualbox do |vb|
     vb.customize ["modifyvm", :id, "--memory", "1024"]
   end
end
