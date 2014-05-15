

class common {


    include vagrant

    $base_pkg = [ "ntp", "git", "vim", "curl", "ruby-dev", ]
    package { $base_pkg: ensure => "installed" }



    # Install database bindings, and clients

   include '::mysql::client'
   include '::mysql::bindings'
   package { "mongodb-clients": ensure => "installed" }




file { "/etc/puppet/hiera.yaml":
  #  require => Directory["/etc/puppet"],
    ensure => "file",
    content => '---
        :backends:
          - yaml

        :logger: console

        :hierarchy:
          - "%{operatingsystem}"
          - common

        :yaml:
           :datadir: /etc/puppet/hieradata
        '
}



}

class vagrant{

# make the vagrant structure specific to the local vagrant enviroment

file { ["/vagrant/web/", "/vagrant/web/conf", "/vagrant/web/platform", "/vagrant/web/ui", "/vagrant/web/logs" ] :
    ensure => "directory",
}



# setup vagrant hosts

host { 'haproxy': ip => '192.168.100.10', host_aliases => 'haproxy.local', }
host { 'web': ip => '192.168.100.20', host_aliases => 'web.local', }
host { 'mongo': ip => '192.168.100.30', host_aliases => 'mongo.local', }
host { 'mysql': ip => '192.168.100.50', host_aliases => 'mysql.local', }
host { 'auth': ip => '192.168.100.60', host_aliases => 'auth.local', }
host { 'log': ip => '192.168.100.70', host_aliases => 'log.local', }
host { 'monitor': ip => '192.168.100.80', host_aliases => 'monitor.local', }
host { 'command': ip => '192.168.100.90', host_aliases => 'command.local', }


}
