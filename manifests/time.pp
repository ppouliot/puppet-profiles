# == Class: profiles::time
#
# A class to define the time services required
# in a managed site
#
class profiles::time ( $ntpservers, $timezone ){

  validate_string( $ntpservers, 'No ntp servers are defined.'  )
  validate_string( $timezone, '(^UTC)$', 'UTC Timezone is required for managed nodes' )

  validate_re($::kernel, '(^Linux|windows)$', "Puppet module ${module_name} only works on Linux and Windows Kernels.")

  $site_ntp_alert   = "Fulling Site requirements for ${::kernel} NTP configuration on ${::fqdn}"
  $site_ntp_failure = "FAILURE: ${::fqdn} failed to meet the requirements of Puppet module ${module_name}."

  case $::kernel {
    'Linux':{
      notice( $site_ntp_alert )
      class {'ntp':
        servers => [$::ntp_servers],
      }
      $network_time = 'puppet_managed'
    }

    'windows':{
      notice( $site_ntp_alert )
      class {'windows_time':
        w_timezone => $profiles::time::timezone,
      }
      $network_time = 'puppet_managed'
    }
    default:{
      fail( $site_ntp_failure )
    }
  }

}
