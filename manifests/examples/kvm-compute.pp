node
  'kvm-compute01.openstack.tld',
  'kvm-compute02.openstack.tld',
  'kvm-compute03.openstack.tld',
  'kvm-compute04.openstack.tld',
  'kvm-compute05.openstack.tld',
  'kvm-compute06.openstack.tld',
  'kvm-compute07.openstack.tld',
  'kvm-compute08.openstack.tld',
  'kvm-compute09.openstack.tld',
  'kvm-compute10.openstack.tld',
  'kvm-compute11.openstack.tld',
  'kvm-compute12.openstack.tld',
  'kvm-compute105.openstack.tld',
  'c1-r1-u07',
  'c1-r1-u11',
  'c1-r1-u17',
  'c1-r1-u15',
  'c1-r1-u13',
  'eth0-c2-r3-u03',
  'eth0-c2-r3-u08',
  'eth0-c2-r3-u20',
  'eth0-c2-r3-u21',
  'eth0-c2-r3-u22',
  'eth0-c2-r3-u23',
# 'eth0-c2-r3-u25', ## possible reassignment as Hopper
# 'eth0-c2-r3-u27', ## possible reassignment as Hopper
  'eth0-c2-r3-u39'
# 'eth0-c2-r3-u40'
{

  $openstack_controller = '10.21.7.41'
  $network_controller   = '10.21.7.42'
  $neutron_password     = '4b39c057433e4ef9'

  class{'basenode':}
  #class{'dell_openmanage':}
  case $bios_vendor {
    'Dell Inc.':{
#     class{'dell_openmanage':}
    }
    default: { notify{"You're not Dell":}}
  }
  class{'sensu':}
  class{'sensu_client_plugins': require => Class['sensu'],}
#  class{'dell_openmanage::firmware::update':}
  class{'jenkins::slave':
    labels    => 'kvm',
    masterurl => 'http://jenkins.openstack.tld:8080',
  }
  class {'packstack':
    openstack_release => 'havana',
    controller_host   => $openstack_controller,
    network_host      => $network_controller,
    kvm_compute_host  => $ipaddress,
  }
  case $hostname {
    'kvm-compute01',
    'kvm-compute02',
    'kvm-compute03',
    'kvm-compute04',
    'kvm-compute05',
    'kvm-compute06':
        {
#          $data_interface = 'em2'
          $if_type = 'em'
          $if_start = 1
        }
    default:
#    'kvm-compute07',
#    'kvm-compute08',
#    'kvm-compute09',
#    'kvm-compute10',
#    'kvm-compute11':
        {
#          $data_interface = 'eth1'
          $if_type = 'eth'
          $if_start = 0
        }
#    default: 
#        { notify {"This isn't for ${hostname}":}
#    }
  }
  $mgmt_interface = "${if_type}${if_start}"
  $data_interface = "${if_type}${if_start + 1}"
  notify {"mgmt_interface = '${mgmt_interface}'":}
  notify {"data_interface = '${data_interface}'":}
#  case $hostname {
#    'kvm-compute01',
#    'kvm-compute02',
#    'kvm-compute03',
#    'kvm-compute04',
#    'kvm-compute05',
#    'kvm-compute06',
#    'kvm-compute07': {}

#    default: {
#    'kvm-compute08',
#    'kvm-compute09',
#    'kvm-compute10',
#    'kvm-compute11':{
    notify {'Files should happen now...':}
    file {'/etc/nova':
      ensure => directory,
      owner  => 'root',
      group  => 'root',
#     mode    => '0755',
#     recurse => true,
#     source  => 'puppet:///extra_files/nova',
    }
    file {'/etc/neutron':
      ensure => directory,
      owner  => 'root',
      group  => 'root',
#     mode    => '0755',
#     recurse => true,
#     source  => "puppet:///extra_files/${data_interface}-neutron/neutron",
    }

    file {'/etc/neutron/plugins':
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
#     mode    => '0755',
      require => File['/etc/neutron'],
    }
    file {'/etc/neutron/plugins/linuxbridge':
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
#     mode   => '0755',
      require => File['/etc/neutron/plugins'],
    }

    file {'/etc/neutron/plugins/linuxbridge/linuxbridge_conf.ini':
      ensure  => file,
      owner   => 'root',
      group   => 'neutron',
      mode    => '0664',
      content => template('kvm/linuxbridge_conf.ini.erb'),
      require => File['/etc/neutron/plugins/linuxbridge'],
    }

    file {'/etc/neutron/plugin.ini':
      ensure  => link,
      owner   => 'root',
      group   => 'neutron',
      mode    => '0664',
      target  => '/etc/neutron/plugins/linuxbridge/linuxbridge_conf.ini',
      require => File['/etc/neutron'],
    }

    file {'/etc/neutron/neutron.conf':
      ensure  => file,
      owner   => 'root',
      group   => 'neutron',
      mode    => '0664',
      content => template('kvm/neutron.conf.erb'),
      require => File['/etc/neutron'],
    }

    file {'/etc/neutron/rootwrap.conf':
      ensure  => file,
      owner   => 'root',
      group   => 'neutron',
      mode    => '0644',
      content => template('kvm/rootwrap.conf.neutron.erb'),
      require => File['/etc/neutron'],
    }

    file {'/etc/neutron/policy.json':
      ensure  => file,
      owner   => 'root',
      group   => 'neutron',
      mode    => '0664',
      content => template('kvm/policy.json.erb'),
      require => File['/etc/neutron'],
    }

    file {'/etc/nova/nova.conf':
      ensure  => file,
      force   => true,
      owner   => 'root',
      group   => 'root',
      mode    => '0664',
      content => template('kvm/nova.conf.erb'),
      require => File['/etc/nova'],
    }

    file {'/etc/testrootwrap.conf':
      ensure  => absent,
#       ensure  => file,
      force   => true,
      owner   => 'root',
      group   => 'root',
      mode    => '0664',
      content => template('kvm/nova-rootwrap.conf.erb'),
      require => File['/etc/nova'],
    }

    file {'/etc/testapi-paste.ini':
      ensure  => absent,
#       ensure  => file,
#       force   => true,
      owner   => 'root',
      group   => 'root',
      mode    => '0664',
      content => template('kvm/nova-api-paste.ini.erb'),
      require => File['/etc/nova'],
    }

    file {'/etc/testrelease':
      ensure  => absent,
#       ensure  => file,
#       force   => true,
      owner   => 'root',
      group   => 'root',
      mode    => '0664',
      content => template('kvm/nova-release.erb'),
      require => File['/etc/nova'],
    }

    file {'/etc/testpolicy.json':
      ensure  => absent,
#     ensure  => file,
#     force   => true,
      owner   => 'root',
      group   => 'root',
      mode    => '0664',
      content => template('kvm/nova-policy.json.erb'),
      require => File['/etc/nova'],
    }

#       ini_setting {
#        'vncserver_listen':
#          path   => '/etc/nova/nova.conf',
#          section => 'DEFAULT',
#          setting => 'vncserver_listen',
#          value   => "${ipaddress_eth0}",
#          ensure => present,
#          require => File['/etc/nova'],
#       }
#       
#       ini_setting {
#        'vncserver_proxyclient_address':
#          path   => '/etc/nova/nova.conf',
#          section => 'DEFAULT',
#          setting => 'vncserver_proxyclient_address',
#          value   => "${ipaddress_eth0}",
#          ensure => present,
#          require => File['/etc/nova'],
#       }
#     }
#    default: { 
#       #notify {"This isn't for ${hostname}":}
#    }
#    }
#  }
#  ini_setting {
#   'reserved_host_disk_mb':
#     path   => '/etc/nova/nova.conf',
#     section => 'DEFAULT',
#     setting => 'reserved_host_disk_mb',
#     value   => "512",
#     ensure => present,
#  }
#  ini_setting {
#   'disk_allocation_ratio':
#     path   => '/etc/nova/nova.conf',
#     section => 'DEFAULT',
#     setting => 'disk_allocation_ratio',
#     value   => "0.9",
#     ensure => present,
#  }
#  file {"/etc/sysconfig/network-scripts/ifcfg-${data_interface}":
#    ensure => file,
#    owner  => '0',
#    group  => '0',
#    mode   => '0644',
#    source => "puppet:///modules/packstack/ifcfg-${data_interface}",
#  }
  package {['openstack-nova-compute',
            'openstack-selinux',
            'openstack-neutron-openvswitch',
            'openstack-neutron-linuxbridge',
            'python-slip',
            'python-slip-dbus',
            'libglade2',
            'nagios-common',
            'tuned',
            'yum-plugin-priorities',
            'system-config-firewall',
            'telnet',
            'nrpe',
            'centos-release-xen',
            'openstack-ceilometer-compute'] :

    ensure => 'present',
  }
#  exec {'centos_release_xen_update':
#    command   => "/usr/bin/yum update -y --disablerepo=* --enablerepo=Xen4CentOS kernel",
#    logoutput => true,
#    timeout   => 0,
#  }
# No longer going to ensure these via puppet.  Will instead monitor via Sensu to facilitate investigation, as these should never halt.
#  service {
#    'libvirtd',
#    'openvswitch',
#    'openstack-nova-compute',
#    'neutron-linuxbridge-agent':
#    ensure  => running,
#    require => [
#      File["/etc/sysconfig/network-scripts/ifcfg-${data_interface}"],
#      #Exec['centos_release_xen_update'],
#      Class['packstack'],
#      ],
#  }

}


node
  'eth0-c2-r3-u06',
  'eth0-c2-r3-u11',
# 'eth0-c2-r3-u13',
# 'eth0-c2-r3-u14',
  'eth0-c2-r3-u16',
  'eth0-c2-r3-u28',
# 'eth0-c2-r3-u30',
# 'eth0-c2-r3-u31',
# 'eth0-c2-r3-u32',
  'eth0-c2-r3-u33',
  'c1-r1-u09',
  'c1-r1-u05',
  'c1-r1-u03',
  'c1-r1-u01',
  {
  class{'basenode':}
  #class{'dell_openmanage':}
  case $bios_vendor {
    'Dell Inc.':{
      class{'dell_openmanage':}
    }
    default: { notify{"You're not Dell":}}
  }
  class{'sensu':}
  class{'sensu_client_plugins': require => Class['sensu'],}
# class{'dell_openmanage::firmware::update':}
  class{'jenkins::slave':
    labels    => 'kvm',
    masterurl => 'http://jenkins.openstack.tld:8080',
  }
  class {'packstack':
    openstack_release => 'havana',
    controller_host   => '10.21.7.41',
    network_host      => '10.21.7.42',
    kvm_compute_host  => $ipaddress,
  }
  $data_interface = 'eth1'
  file {'/etc/nova':
    ensure => directory,
#   recurse => true,
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
#   source => 'puppet:///extra_files/nova',
  }
  ini_setting {
    'vncserver_listen':
      ensure  => present,
      path    => '/etc/nova/nova.conf',
      section => 'DEFAULT',
      setting => 'vncserver_listen',
      value   => $ipaddress_eth0,
      require => File['/etc/nova'],
  }
  ini_setting {
    'vncserver_proxyclient_address':
      ensure  => present,
      path    => '/etc/nova/nova.conf',
      section => 'DEFAULT',
      setting => 'vncserver_proxyclient_address',
      value   => $ipaddress_eth0,
      require => File['/etc/nova'],
  }
  file {'/etc/neutron':
    ensure  => directory,
    recurse => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    source  => "puppet:///extra_files/${data_interface}-neutron/neutron",
  }
  file {"/etc/sysconfig/network-scripts/ifcfg-${data_interface}":
    ensure => file,
    owner  => '0',
    group  => '0',
    mode   => '0644',
    source => "puppet:///modules/packstack/ifcfg-${data_interface}",
  }
  package {[
    'openstack-selinux',
    'openstack-neutron-openvswitch',
    'openstack-neutron-linuxbridge',
    'python-slip',
    'python-slip-dbus',
    'libglade2',
    'nagios-common',
    'tuned',
    'yum-plugin-priorities',
    'system-config-firewall',
    'telnet',
    'nrpe',
    'centos-release-xen',
    'openstack-ceilometer-compute']:
    ensure => 'present',
  }
  package {'openstack-nova-compute':
    ensure => '2013.2.3-1.el6',
  }
  service { 'network':
    ensure    =>  running,
    subscribe => File["/etc/sysconfig/network-scripts/ifcfg-${data_interface}"],
  }
# No longer going to ensure these via puppet.  Will instead monitor via Sensu to facilitate investigation, as these should never halt.
  service {
    ['libvirtd',
    'openvswitch',
    'openstack-nova-compute',
    'neutron-linuxbridge-agent']:
    ensure  => stopped,
    require => [
      File["/etc/sysconfig/network-scripts/ifcfg-${data_interface}"],
      #Exec['centos_release_xen_update'],
      Class['packstack'],
      ],
  }
}
