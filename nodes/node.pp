
############ Prod environments  ###########


if $hostname =~ /-prd-(\d+)/ {

include prod_config

}


############ dev environments  ###########


if $hostname =~ /-dev-(\d+)/ {

include dev_config

}




############ test  environments  ###########

if $hostname =~ /-tst-(\d+)/ {

include test_config

}


#################### web servers #####################

if $hostname =~ /^web-(prd|dev|tst)-(\d+)/ {


# node, grunt, curl, yoeman,
$web_pkg = [ "node",  "ssl-cert","uwsgi-plugin-python", "python-pip", "npm", "mongodb-clients",  "python-virtualenv", "virtualenvwrapper", "nginx-full", "uwsgi" ]


package { $web_pkg: ensure => "installed" }


service { "nginx":
#    require => Package["nginx-full"],
    ensure => running,
    enable => true,
}

service { "uwsgi":
  #  require => Package["uwsgi"],
    ensure => running,
    enable => true,
}





file { "/vagrant/web/ui/default.html":
    require => File["/vagrant/web/ui/"],
    ensure => "file",
    content => "<!DOCTYPE html>
        <html><body>
        Hello, world.
        "
}


file { "/vagrant/web/conf/nginx-ui.conf":
    require => [
        Package["nginx-full"],
        File["/vagrant/web/conf/"],
    ],
    ensure => "file",
    content =>
        "server {
            listen 80 default_server;
            server_name _;
            location / { root /vagrant/web/ui/; }
        }",
    notify => Service["nginx"]
}


file { "/etc/nginx/sites-enabled/nginx-ui.conf":
    require => File["/vagrant/web/conf/nginx-ui.conf"],
    ensure => "link",
    target => "/vagrant/web/conf/nginx-ui.conf",
    notify => Service["nginx"]
}

# configure nginx
file { "/etc/nginx/sites-enabled/default":
    require => Package["nginx-full"],
    ensure  => absent,
    notify  => Service["nginx"]
}





file { "/vagrant/web/conf/uwsgi-platform.conf":
    require => [
        Package["uwsgi"],
        File["/vagrant/web/conf/"],
    ],
    ensure => "file",
    content =>
        "[uwsgi]
         plugins = python
         socket = :81
         uwsgi-file =  /vagrant/web/platform/hello_world.py
         logto = /vagrant/web/logs/uwsgi.log
         process = 2
        ",
    notify => Service["uwsgi"],
}


file { "/etc/uwsgi/apps-enabled/uwsgi-platform.conf":
    require => File["/vagrant/web/conf/uwsgi-platform.conf"],
    ensure => "link",
    target => "/vagrant/web/conf/uwsgi-platform.conf",
    notify => Service["uwsgi"],
}



}


#################### haproxy servers #####################

if $hostname =~ /^haproxy-(prd|dev|tst)-(\d+)/ {

  package { haproxy: ensure => "installed" }

}

#################### mongo servers #####################

if $hostname =~ /^mongo-(prd|dev|tst)-(\d+)/ {



class {'::mongodb::server':
 auth => true,
 logappend => 'false',
}

mongodb::db { 'cineglass':
 user          => 'test',
 password => 'cinetest',
}



}

#################### monitor servers #####################


if $hostname =~ /^monitor-(prd|dev|tst)-(\d+)/ {



}

#################### mysql servers #####################

if $hostname =~ /^mysql-(prd|dev|tst)-(\d+)/ {


}

#################### monitor servers #####################

if $hostname =~ /^log-(prd|dev|tst)-(\d+)/ {

}
