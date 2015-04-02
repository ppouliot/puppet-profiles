# == Class: profiles::mgmt_tools
#
# A class to define the mgmt_tools services required
# in a managed site
#
class profiles::mgmt_tools (){


  validate_re($::kernel, '(^Linux|Windows)$', 'This Module only works on Linux and Windows Kernels.')

  $site_mt_alert   = "Fullfulling management tool installation and configuration requirements for ${::kernel} on ${::fqdn}"
  $site_mt_failure = "FAILURE: ${::fqdn} Does not meet the requirments for installation of managment tools"

  case $kernel {

    'Linux':{
      notice( $site_mt_alert )
      package{[
        'expect','screen','minicom','ipmitool','openipmi']:
        ensure => latest,
      }
    }

    'Windows':{
      notice( $site_mt_alert )
      Package{ provider => 'chocolatey',}
    }
    default:{
      fail("${::fqdn} doesn't meet the requirements for management tool installation.")
    }
  }

}
