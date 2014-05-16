
#### define stages

stage { 'pre-stage':
   before => Stage['main'],
 }

stage { 'post-stage':
  require => Stage['main'],
}



### link classes with the stages

class { 'do-post-stage':
 stage => post-stage,

}



class { 'do-pre-stage':
  stage => pre-stage,
}





# define classes to run before and after

class do-pre-stage {

exec { "apt-update":
    command => "/usr/bin/apt-get update"
}




file { "/etc/puppet/hiera.yaml":
  #  require => Directory["/etc/puppet"],
    ensure => "file",
    content => '---
        :backends:
          - yaml

        :logger: console

        :hierarchy:
          - "%{operatingsystem}"
          - common

        :yaml:
           :datadir: /etc/puppet/hieradata
        '
    }
}

class do-post-stage {


}
