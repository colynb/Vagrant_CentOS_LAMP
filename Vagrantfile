# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
    config.vm.box = "centos63_64"
    config.vm.box_url = "https://dl.dropbox.com/u/7225008/Vagrant/CentOS-6.3-x86_64-minimal.box"
    config.vm.network :hostonly, "33.33.33.11"
    config.vm.forward_port 80, 8080
    config.vm.provision :puppet
end