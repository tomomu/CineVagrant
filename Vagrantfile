# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provision :puppet, :module_path => %w(modules) do |puppet|
  # fix `fqdn_rand` error
   puppet.manifest_file = "site.pp"
   puppet.facter = { 'fqdn' => config.vm.hostname }
   puppet.module_path = "modules"
end


config.vm.box_check_update = false


# ****************** haproxy ***************

  config.vm.define "haproxy", autostart: false  do |haproxy|
    config.vm.box = "ubuntu/trusty64"
    config.vm.hostname = 'haproxy-dev-001'
    config.vm.network "private_network", ip: "192.168.100.10",
       virtualbox__intnet: true
    config.vm.provider "virtualbox" do |v|
      v.memory = 512
      v.cpus = 1
    end
  end


# ****************** web ***************

  config.vm.define "web", primary: true  do |web|
    config.vm.box = "ubuntu/trusty64"
    config.vm.box_check_update = true
    config.vm.hostname = 'web-dev-001'
    config.vm.network "forwarded_port", guest: 80, host: 1080
    config.vm.network "forwarded_port", guest: 81, host: 1081
    config.vm.network "private_network", ip: "192.168.100.20",
       virtualbox__intnet: true
    config.vm.provider "virtualbox" do |v|
      v.memory = 1024
      v.cpus = 1
    end
  end


# ***************** mongo *****************

  config.vm.define "mongo" , autostart: false do |mongo|
    config.vm.box = "ubuntu/trusty64"
    config.vm.box_check_update = true
    config.vm.hostname = 'mongo-dev-001'
    config.vm.network "private_network", ip: "192.168.100.30",
       virtualbox__intnet: true
    config.vm.network "forwarded_port", guest: 27017, host: 27017,  auto_correct: true
    config.vm.network "forwarded_port", guest: 28017, host: 28017,  auto_correct: true
    config.vm.provider "virtualbox" do |v|
     v.memory = 1024
     v.cpus = 2
    end
  end



# ***************** mysql *****************

  config.vm.define "mysql" , autostart: false do |mongo|
    config.vm.box = "ubuntu/trusty64"
    config.vm.hostname = 'mysql-dev-001'
    config.vm.network "private_network", ip: "192.168.100.40",
       virtualbox__intnet: true
    config.vm.provider "virtualbox" do |v|
     v.memory = 512
     v.cpus = 1
    end
  end


# ***************** auth *****************

  config.vm.define "auth" , autostart: false do |mongo|
    config.vm.box = "ubuntu/trusty64"
    config.vm.hostname = 'auth-dev-001'
    config.vm.network "private_network", ip: "192.168.100.50",
       virtualbox__intnet: true
    config.vm.provider "virtualbox" do |v|
     v.memory = 512
     v.cpus = 1
    end
  end


# ***************** log *****************

  config.vm.define "log" , autostart: false do |mongo|
    config.vm.box = "hashicorp/precise64"
    config.vm.hostname = 'log-dev-001'
    config.vm.network "private_network", ip: "192.168.100.60",
       virtualbox__intnet: true
    config.vm.provider "virtualbox" do |v|
     v.memory = 512
     v.cpus = 1
    end
  end

# ***************** monitor *****************

  config.vm.define "monitor" , autostart: false do |mongo|
    config.vm.box = "ubuntu/trusty64"
    config.vm.hostname = 'monitor-dev-001'

    config.vm.network "private_network", ip: "192.168.100.70",
       virtualbox__intnet: true
    config.vm.provider "virtualbox" do |v|
     v.memory = 512
     v.cpus = 1
    end
  end

# ***************** command *****************

  config.vm.define "command" , autostart: false do |mongo|

    config.vm.hostname = 'command-dev-001'
    config.vm.network "private_network", ip: "192.168.100.90",
       virtualbox__intnet: true
    config.vm.provider "virtualbox" do |v|
     v.memory = 512
     v.cpus = 1
    end
  end


end
