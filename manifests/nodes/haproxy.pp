

#################### haproxy servers #####################

if $hostname =~ /^haproxy-(prd|dev|tst)-(\d+)/ {

package { "haproxy": ensure => "installed" }

service {  "haproxy": ensure => "running" }


file { "/etc/haproxy/haproxy.cfg":
#    notify  => Service["haproxy"],
#    require => Package["haproxy"],
    content => "
       global
        log /dev/log    local0
        log /dev/log    local1 notice
        chroot /var/lib/haproxy
        user haproxy
        group haproxy
        daemon

       defaults
         log     global
         mode    http
         option  httplog
         option  dontlognull
         retries 3
         option redispatch
         timeout connect  5000
         timeout client  10000
         timeout server  10000

        listen cineglass-static 0.0.0.0:80
          mode http
          stats enable
          stats uri /?stats
          stats realm Private
          stats auth stats:stats_user2
          balance leastconn
          option httpclose
          option forwardfor
          server web 192.168.100.20:80 check

        listen cineglass-dynamic 0.0.0.0:81
          mode http
          stats enable
          stats uri /?stats
          stats realm Private
          stats auth stats:stats_user2
          balance leastconn
          option httpclose
          option forwardfor
          server web 192.168.100.20:81 check

               "
}

}
