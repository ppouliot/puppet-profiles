# == Class: profiles::hypervisor
#
# A class to define the hypervisor services required
# in a managed site
#
class profiles::hypervisor (){

  validate_re($::kernel, '(^Linux|windows)$', 'This Module only works on Linux and Windows Kernels.')

  $site_hypervisor_alert   = "Fullfilling Site requirements for ${::kernel} Hypervisor configuration on ${::fqdn}"
  $site_hypervisor_failure = "FAILURE: ${::fqdn} failed to meet the hypervisor requirements to operate in this site."

  case $kernel {

    'Linux':{
      notice( $site_hypervisor_alert )
    }

    'windows':{
      notice( $site_hypervisor_alert )
    }

    default:{
      fail( $site_hypervisor_failure )
    }

  }

}
