# == Class: profiles::time
#
# A class to define the time services required
# in a managed site
#
class profiles::time ( $ntpservers, $timezone ){

  validate_string( $ntpservers, 'No ntp servers are defined.'  )
  validate_string( $timezone, '(^UTC)$', 'UTC Timezone is required for managed nodes' )

  validate_re($::kernel, '(^Linux|Windows)$', 'This Module only works on Linux and Windows Kernels.')

  $site_ntp_alert   = "Fulling Site requirements for ${::kernel} NTP configuration on ${::fqdn}",
  $site_ntp_failure = "FAILURE: ${::fqdn} failed to meet the requirements to operate in this site.

  case $kernel {

    'Linux':{
      notice( $site_ntp_alert )
      class {'ntp':
        servers => [$ntp_servers],
      }
    }

    'Windows':{
      notice( $site_ntp_alert )
      class {'windows_time':
        servers => [$ntp_servers],
      }
    }

    default:{
      fail("${::fqdn} doesn't meet the requirements to operate in the site.")
    }
  }

}
