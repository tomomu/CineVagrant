

#################### mongo servers #####################

if $hostname =~ /^mongo-(prd|dev|tst)-(\d+)/ {

class {'::mongodb::server':
  auth => true,
}




mongodb::db { 'testdb':
  user          => 'logger',
  password => 'frogger',
}


package { 'genghisapp':
    ensure   => 'installed',
    provider => 'gem',
}




}
