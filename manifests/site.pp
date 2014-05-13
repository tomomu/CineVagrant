
import "nodes/*.pp"
import "base.pp"



include common
include vagrant


exec { "apt-update":
    command => "/usr/bin/apt-get update"
}
