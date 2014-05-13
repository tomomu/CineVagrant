

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
