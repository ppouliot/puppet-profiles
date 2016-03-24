# == Class: profiles::hypervisor
#
# A class to define the hypervisor services required
# in a managed site
#
class profiles::hypervisor (){

  validate_re($::kernel, '(^Linux|windows)$', 'This Module only works on Linux and Windows Kernels.')

  $site_hypervisor_alert   = "Fullfilling Site requirements for ${::kernel} Hypervisor configuration on ${::fqdn}"
  $site_hypervisor_failure = "FAILURE: ${::fqdn} failed to meet the hypervisor requirements to operate in this site."

  case $::kernel {

    'Linux':{
      notice( $site_hypervisor_alert )
    }

    'windows':{
      notice( $site_hypervisor_alert )
    }

    default:{
<<<<<<< HEAD
      fail( $site_hypervisor_failure )
=======
      fail("${::kernel} doesn't meet the requirements to operate in the site.")
>>>>>>> aaf575e541a6e2a8d17d5e400afe8b17098abc74
    }

  }

}
