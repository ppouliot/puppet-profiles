# = Class: vpn_user
# Defining the creation of vpn user accounts
# usage:
#
# vpn_user{'tom':
#   vpn_server_instance_name => 'hypervci',
#   vpn_server_external_ipaddress => '192.168.1.92',
#   vpn_user_emailaddress => 'tom@openstack.tld',
# }
#
define profiles::vpn_user (
  $vpn_user_id = $name,
  $vpn_server_instance_name,
  $vpn_server_external_ipaddress,
  $vpn_user_email_address ){

  # Create an openvpn account
  openvpn::client { $vpn_user_id:
    server => "${vpn_server_instance_name}",
    remote_host => $vpn_server_external_ipaddress,
  } ->
  # mail the user information
  exec{"Tar_Certs_and_OVPN_and_mail_to__${vpn_user_id}":
    command   => "/usr/bin/touch /etc/openvpn/${vpn_server_instance_name}/download-configs/${vpn_user_id}.mailsent && /usr/bin/mail -s \"VPN Credentials and Certificates for ${vpn_user_id}\" -a /etc/openvpn/${vpn_server_instance_name}/download-configs/${vpn_user_id}.tar.gz -a /etc/openvpn/${vpn_server_instance_name}/download-configs/${vpn_user_id}.ovpn ${vpn_user_email_address} < /dev/null",
    cwd       => "/etc/openvpn/${vpn_server_instance_name}/download-configs",
    logoutput => true,
    timeout   => 0,
    onlyif    => "/usr/bin/test ! -f /etc/openvpn/${vpn_server_instance_name}/download-configs/${vpn_user_id}.mailsent",
  }

}
