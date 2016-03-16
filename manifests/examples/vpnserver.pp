# == Class: profiles::vpnserver
class profiles::vpnserver {
#  class {'basenode':}
#  class {'basenode::dhcp2static':}
#  class {'sensu':}
#  class{'sensu_client_plugins': require => Class['sensu'],}

  package {'bridge-utils':
    ensure => latest,
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
#    push        => ['route 10.21.7.0 255.255.255.0'],
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

  openvpn::client {'ppouliot':
    server      => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'nmeier':
    server      => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'trogers':
    server      => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'habdi':
    server      => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'cloudbase':
    server      => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'apilotti':
    server      => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'gsamfira':
    server      => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'vbud':
    server      => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'avladu':
    server      => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'ClaudiuNesa':
    server      => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'gabrielloewen':
    server      => 'hypervci',
    remote_host => '64.119.130.115',
  }
  openvpn::client {'mattneely':
    server      => 'hypervci',
    remote_host => '64.119.130.115',
  }
#  openvpn::client_specific_config {'ppouliot':
#  openvpn::client_specific_config {'ppouliot':
#    server   => 'hypervci',
#    ifconfig => '10.253.253.1 255.255.255.0',
#    route    => ['route 10.21.7.0 255.255.255.0 10.253.253.1',
#                'route 172.18.2.0 255.255.255.0 10.253.253.1'],
#    redirect_gateway => true,
#  }

  class {'quagga':
    ospfd_source => 'puppet:///extra_files/ospfd.conf',
  }
  file {'/etc/quagga/zebra.conf':
    ensure  => file,
    owner   => 'quagga',
    group   => 'quagga',
    mode    => '0640',
    source  => 'puppet:///extra_files/zebra.conf',
    notify  => Service['zebra'],
    require => Class['quagga'],
    before  => Service['zebra'],
  }
}
