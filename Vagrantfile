# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.forward_agent = true
  config.vm.box = 'precise32'
  config.vm.box_url = 'http://files.vagrantup.com/precise32.box'
  config.vm.synced_folder './', '/var/www/portcullis'
  config.vm.provision 'shell', path: 'vagrant/provision.bash'
  config.dnsmasq.domain = '.dev'
  config.dnsmasq.dnsmasqconf = '/etc/dnsmasq.conf'
  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', 2048]
  end
end
