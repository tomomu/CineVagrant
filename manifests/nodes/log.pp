#################### log servers #####################

if $hostname =~ /^log-(prd|dev|tst)-(\d+)/ {



$log_pkg = [ "build-essential", "openjdk-7-jre",  "pwgen", "wget", ]

package { $log_pkg: ensure => "installed" }


class { 'graylog2':
  mongo_db_host     => 'mongo.example42.com', # Default 127.0.0.1
  mongo_db_port     => '27020', # Default 27017
  mongo_db_name     => 'grey', # Default graylog2
  mongo_user        => 'grey', # Default grayloguser
  mongo_password    => 'mypw', # Default 123 - CHANGE IT!
  puppi    => true,
}


}
