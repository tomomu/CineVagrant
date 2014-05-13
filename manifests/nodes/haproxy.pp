

#################### haproxy servers #####################

if $hostname =~ /^haproxy-(prd|dev|tst)-(\d+)/ {

  package { haproxy: ensure => "installed" }

}
