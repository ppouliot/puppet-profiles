# == Class: profiles::puppet_policy
# 
# A class to define the puppet policies required in a managed site
#
class profiles::puppet_policy {
  case $::osfamily {
    'CoreOS':{
      warning("${::fqdn} is a CoreOS host and has successully executed puppet agent connection.")
    }
 
    default:{
      include ::puppet_agent
    }
  }
}
