


#################### web servers #####################

if $hostname =~ /^web-(prd|dev|tst)-(\d+)/ {


######### Install deb pkgs


$web_pkg = [ "node",  "ssl-cert","uwsgi-plugin-python", "python-pip", "npm","nodejs", "nodejs-legacy", "python-virtualenv", "virtualenvwrapper","nginx-full", "uwsgi", "python-dev",]


package { $web_pkg: ensure => "installed" }

# install gem pkgs

$gem_pkg = [  "compass",  ]
package { $gem_pkg: ensure   => 'installed', provider => 'gem', }

######## install node pkgs

$npm_pkg = [  "yo", "generator-angular", "grunt-cli",  ]

package { $npm_pkg: ensure   => 'installed',
                    provider => 'npm',
                    require => Package["npm"]
}



######### Install web servers


service { "nginx":
#    require => Package["nginx-full"],
    ensure => running,
    enable => true,
    require => Package["nginx-full"],
}

service { "uwsgi":
  #  require => Package["uwsgi"],
    ensure => running,
    enable => true,
    require => Package["uwsgi"],
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
