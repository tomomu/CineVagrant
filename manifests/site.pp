
import "nodes/node.pp"
import "templates.pp"



include common
include vagrant


exec { "apt-update":
    command => "/usr/bin/apt-get update"
}
