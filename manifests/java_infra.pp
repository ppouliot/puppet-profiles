# = Class: profiles::java_infra
#
# A class to ensure remote access is enabled on a managed host
# We will also bind to the $kernel fact and split the run between
# windows and linux nodes
#
class profiles::java_infra () {
  validate_re($::kernel, '(^Linux|Windows)$', 'This Module only works on Linux and Windows Kernels.')
  $java_alert   = "Fullfilling ** JAVA ** site requirements based on host ${::fqdn} detection of ${::kernel} kernel"
  $java_failure = "FAILURE: ${::fqdn} failed to meet the Java requirements to operate in this site."

  case $kernel {
    'Linux':{
      notice( $java_alert )
      class{'java':}
    }

    'Windows':{
      notice( $java_alert )
      ## TODO Add windows_java Here
      warning("WINDOWS NEEDS A CLEAN JAVA MODULE")
    }
    default:{
      fail( $java_failure )
    }
  }
}
