

#################### mongo servers #####################

if $hostname =~ /^mongo-(prd|dev|tst)-(\d+)/ {


class { 'mongodb':
}


#### create test users  ####


mongodb::user { 'cineglass':
  password => 'brokengla$$',
}
mongodb::user { 'graylog':
  password => '2gray2',
}

}
