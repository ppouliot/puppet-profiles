# == Class: profiles::ci_variables
#
# A class to define the ci_variables services required
# in a managed site
#
profiles::ci_variables
  $jenkins_master,
  $jenkins_label,
  $ad_domain_controller,
  $proxy_address

  validate_string( $jenkins_master, 'No Jenkins Masters are defined.'  )
  validate_string( $ad_domain_controller, 'Valid CI Nodes require an Active directoy controller'  )
  validate_string( $proxy_address, 'Valid CI Nodes require an a proxy cache'  )
}
