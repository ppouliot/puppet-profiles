# = Class: profiles::remote_access
#
# A class to ensure remote access is enabled on a managed host
# We will also bind to the $kernel fact and split the run between
# windows and linux nodes
#
class profiles::remote_access () {
  validate_re($::kernel, '(^Linux|Windows)$', 'This Module only works on Linux and Windows Kernels.')
  $remote_access_alert   = "Fullfilling ** Remote Access ** site requirements based on host ${::fqdn} detection of ${::kernel} kernel"
  $remote_access_failure = "FAILURE: ${::fqdn} failed to meet the requirements to operate in this site."

  case $kernel {

    'Linux':{
      notice( $remote_access_alert )
      class{'ssh::server':
        options => {
          'PermitRootLogin' => 'yes',
        }
      }
      $remote_access_enabled = 'puppet_managed'
    }

    'Windows':{
      notice( $remote_access_alert )
      ## TODO Add WinRM Here
      fail("WINDOWS NEEDS REMOTE ACCESS")
      $remote_access_enabled = 'puppet_managed'
    }

    default:{
      fail("${::fqdn} doesn't meet the requirements to operate in the site.")
    }
  }
}
