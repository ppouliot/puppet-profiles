# == Class: profiles::time_policy
#
# A class to define the time services required
# in a managed site
#
class profiles::time_policy (
  $ntpservers,
  String $timezone,
){
  include ::stdlib
#  unless ($ntpservers =~ Stdlib::FQDN) {
#    fail('NTP Server value for synchronizing time on managed machines is required and must be supplied!')
#  }
  if $::kernel {
    assert_type(Pattern[/(^Linux|Windows)$/], $::kernel) |$a, $b| {
      warning('The time management policy currently only works on Linux and Windows based systems.')
    }
  }
  $site_ntp_alert   = "Fulfilling Site requirements for ${::kernel} NTP configuration on ${::fqdn}!"
  $site_ntp_failure = "FAILURE: ${::fqdn} failed to meet the requirements of the time policy!"
  case $::kernel {
    'Linux':{
      case $operatingsystem {
        'Ubuntu':{
          case $operatingsystemrelease {
            '18.04':{
              class{'chrony':
                servers => [$ntpservers],
              }
            }
            'default':{
              class {'ntp':
                servers => [$ntpservers],
              }
            }
          }
        }
        'default':{
           class {'ntp':
             servers => [$ntpservers],
           }
        }
      }
      class{'timezone':
        timezone => $timezone,
      }
    }
    'windows':{
      class {'windows_time':
        w_timezone => $timezone,
      }
      $network_time = 'puppet_managed'
    }
    'default':{
      fail( $site_ntp_failure )
    }
  }
}
