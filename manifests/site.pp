



import "nodes/*.pp"
import "templates.pp"


include common


exec { "apt-update":
    command => "/usr/bin/apt-get update"
}
