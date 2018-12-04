class profiles::vpn {
  class{'epel':} ->
  class{'selinux':
    mode => 'disabled',
    type => 'targeted',
  } ->
  package {['bridge-utils','iptables-services','net-tools','mailx','python-virtualenv']:
    ensure => latest,
  } ->
  # Controls IP Packet Forwarding
  sysctl { 'net.ipv4.ip_forward': value => '1' }
  # Controls Source route verification
  sysctl { 'net.ipv4.conf.default.rp_filter': value => '1' }
  # Do not acceccapt source routing
  sysctl { 'net.ipv4.conf.default.accept_source_route': value => '0' }
  # Controls use of TCP SYN Cookies
  sysctl { 'net.ipv4.tcp_syncookies': value => '1' }
  # Controls the system request debugging functionality
  sysctl { 'kernel.sysrq': value => '0' }
  # Controls whether core dumps will append the pid to the core filename.
  # Useful for debugging multi-threaded applications
  sysctl { 'kernel.core_uses_pid': value => '1' }
  # Controls the default maximum sieze of a message queue
  sysctl { 'kernel.msgmnb': value => '65536' }
  # Controls the  maximum size of a message
  sysctl { 'kernel.msgmax': value => '65536' }
  # Controls the  maximum shared segment size of a message
  sysctl { 'kernel.shmmax': value => '68719476736' }
  # Controls the  maximum number of shared memory segments, in pages
  sysctl { 'kernel.shmall': value => '4294967296' }

  openvpn::server{'hypervci':
    country         => 'US',
    province        => 'MA',
    city            => 'Cambridge',
    organization    => 'opentack.tld',
    email           => 'root@openstack.tld',
#    dev            => 'tap0',
    local           => $::ipaddress,
#    proto          => 'tcp',
    server          => '10.253.253.0 255.255.255.0',
    management      => true,
#    management_ip   => '127.0.0.1',
    management_port => '5555',
    push            => [
#     'route 10.21.7.0 255.255.255.0 10.253.353.1',
      'redirect-gateway def1 bypass-dhcp',
      'dhcp-option DNS 10.21.7.1',
      'dhcp-option DNS 8.8.8.8',
      'dhcp-option DNS 8.8.4.4',
#     'topology subnet'
                    ],
#    push           => ['route 10.21.7.0 255.255.255.0'],
  } ->

  firewall { '100 snat for network openvpn':
    chain    => 'POSTROUTING',
    jump     => 'MASQUERADE',
    proto    => 'all',
    outiface => "ens2f0",
    source   => '10.253.253.0/24',
    table    => 'nat',
  } ->
  firewall {'200 INPUT allow DNS':
    action => accept,
    proto  => 'udp',
    sport  => 'domain'
  } ->

  class {'quagga':
    ospfd_source => 'puppet:///extra_files/ospfd.conf',
  } 
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
  package{[
    'gzip',
    'p7zip',
    'python-pip',
    'python-GeoIP',
    'python-humanize',
    'python-ipaddr',
    'python-six',
    'python-bottle',
    'python-semantic_version',
  ]:
    ensure => latest,
  } ->
  vcsrepo {'/var/www/html/openvpn-monitor':
    ensure   => present,
#    ensure   => latest,
    provider => git,
    source   => 'https://github.com/furlongm/openvpn-monitor',
#    revision => 'v1.0.0rc17',
#    revision => 'master',
    owner    => 'apache',
    group    => 'apache',
    require  => Class['apache'],
  } ->
  file{'/var/www/html/openvpn-monitor/openvpn-monitor.conf':
    ensure => file,
    owner  => apache,
    group  => apache,
    content => '# This file is Puppet Managed
[OpenVPN-Monitor]
site=OpenStack CI Cambridge
#logo=logo.jpg
logo=http://swupdate.openvpn.net/community/icons/ovpntech_key.png
#latitude=-37
#longitude=144
maps=True
geoip_data=/usr/share/GeoIP/GeoIPCity.dat

[VPN1]
host=localhost
port=5555
name=HyperV CI VPN',
  }
  class{'staging':
    path  => '/opt/staging',
    owner => 'root',
    group => 'root',
  }
  staging::file{'GeoliteCity.dat.gz':
    source => 'http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz',
  } ->
  exec{'extract-GeoliteGity.dat':
    command   => '/bin/7za e /opt/staging/GeoliteCity.dat.gz',
    cwd       => '/usr/share/GeoIP',
    creates   => '/usr/share/GeoIP/GeoLiteCity.dat',
    onlyif    => '/bin/test ! -f /usr/share/GeoIP/GeoLiteCity.dat',
    logoutput => true,
    timeout   => 0,
    require   => Package['p7zip','python-GeoIP'],
  } ->
  file{'/usr/share/GeoIP/GeoIPCity.dat':
    ensure => link,
    target => '/usr/share/GeoIP/GeoLiteCity.dat',
  }
  class{'apache': }
  apache::vhost{'vpn.openstack.tld':
    port                        => '80',
    docroot                     => '/var/www/html/openvpn-monitor',
    wsgi_application_group      => '%{GLOBAL}',
    wsgi_daemon_process         => 'wsgi',
    wsgi_daemon_process_options => {
      processes    => '2',
      threads      => '15',
      display-name => '%{GROUP}',
    },
    wsgi_import_script          => '/var/www/html/openvpn-monitor/openvpn-monitor.py',
    wsgi_import_script_options  => {
      process-group     => 'wsgi',
      application-group => '%{GLOBAL}',
    },
    wsgi_process_group          => 'wsgi',
    wsgi_script_aliases         => { '/' => '/var/www/html/openvpn-monitor/openvpn-monitor.py' },
  }

# Include VPN Users Class from manifests/vi_vpn_users.pp
  include ::ci_vpn_users
  include ::revoked_vpn_users
}
