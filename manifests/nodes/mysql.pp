


#################### mysql servers #####################

if $hostname =~ /^mysql-(prd|dev|tst)-(\d+)/ {



class { '::mysql::server':

  root_password    => ::credentials::mysql_root_password,
  override_options => { 'mysqld' => { 'max_connections' => '256' } }
}



}
