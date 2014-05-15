
import "nodes/*.pp"
import "base.pp"
import "parameters/*.pp"



include common
include vagrant


exec { "apt-update":
    command => "/usr/bin/apt-get update"
}
