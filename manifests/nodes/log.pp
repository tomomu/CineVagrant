#################### log servers #####################

if $hostname =~ /^log-(prd|dev|tst)-(\d+)/ {



$log_pkg = [ "build-essential", "openjdk-7-jre",  "pwgen", "wget", ]

package { $log_pkg: ensure => "installed" }



Exec["apt-update"] -> class { 'graylog2':
  server_name       => $hostname,
  external_hostname => $hostname,
}


}
