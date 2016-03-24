# == Class: profiles::node_networking
#
# A class to define the node_networking services required
# in a managed site
#
class profiles::node_networking (){

  validate_re($::kernel, '(^Linux|windows)$', 'This Module only works on Linux and Windows Kernels.')

  $site_node_networking_alert   = "Fullfilling Site requirements for ${::kernel} Site Requirements for Networking configuration on ${::fqdn}"
  $site_node_networking_failure = "FAILURE: ${::fqdn} failed to meet the node_networking requirements to operate in this site."

  case $kernel {

    'Linux':{
      notice( $site_node_networking_alert )
    }

    'windows':{
      notice( $site_node_networking_alert )
    }

    default:{
      fail( $site_node_networking_failure )
    }

  }

}
