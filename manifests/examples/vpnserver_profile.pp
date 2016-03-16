# ==Class: vpnserver_profile
class vpnserver {

  # Required for the fact to work
#  package {'rubysl-ipaddr':
#    ensure   => latest
#    provider => gem,
#  }

  package {'bridge-utils':
    ensure  => latest,
    require => Package['rubysl-ipaddr'],
  }

  openvpn::server{'hypervci':
    country      => 'US',
    province     => 'MA',
    city         => 'Cambridge',
    organization => 'opentack.tld',
    email        => 'root@openstack.tld',
#    dev          => 'tap0',
    local        => $::ipaddress_br0,
#    proto        => 'tcp',
    server       => '10.253.253.0 255.255.255.0',
    push         => [
#     'route 10.21.7.0 255.255.255.0 10.253.353.1',
      'redirect-gateway def1 bypass-dhcp',
      'dhcp-option DNS 10.21.7.1',
      'dhcp-option DNS 8.8.8.8',
      'dhcp-option DNS 8.8.4.4',
#     'topology subnet'
    ],
#    push         => ['route 10.21.7.0 255.255.255.0'],
    require      => Package['bridge-utils'],
  }

  firewall { '100 snat for network openvpn':
    chain    => 'POSTROUTING',
    jump     => 'MASQUERADE',
    proto    => 'all',
    outiface => 'eth0',
    source   => '10.253.253.0/24',
    table    => 'nat',
  }
  firewall {'200 INPUT allow DNS':
    action => accept,
    proto  => 'udp',
    sport  => 'domain'
  }
# vpn
define vpn_remote_user ( $::openvpn_server_name, $::openvpn_remote_host ){

  Openvpn::Client[
#    server      => $openvpn_server_name,
    server      => $::openvpn_server_name,
#    remote_host => $openvpn_remote_host,
    remote_host => $::openvpn_remote_host,
  }

  openvpn::client {$name: }
}

#  class {'quagga':
#    ospfd_source => 'puppet:///extra_files/ospfd.conf',
#  }
#  file {'/etc/quagga/zebra.conf':
#    ensure  => file,
#    owner   => 'quagga',
#    group   => 'quagga',
#    mode    => '0640',
#    source  => 'puppet:///extra_files/zebra.conf',
#    notify  => Service['zebra'],
#    require => Class['quagga'],
#    before  => Service['zebra'],
#  }
}
