node /quartermaster.*/ {
  Quartermaster::Pxe::File <<||>>
  class {'jenkins::slave':
    masterurl => 'http://jenkins.openstack.tld:8080',
  }
  class {'basenode::ipmitools':}
  class {'sensu':}
  class{'sensu_client_plugins': require => Class['sensu'],}
  # Set NTP
  class {'ntp':
    servers => ['bonehed.lcs.mit.edu'],
  }
  class {'quartermaster':}
  class {'network_mgmt':}
  file{'/srv/install/sensu/':
    ensure  => directory,
    recurse => true,
    source  => 'puppet:///extra_files/sensu',
  }
  # This section added for temporary file hosting needs on HV nodes
  file{'/srv/install/hv-files/':
    ensure  => directory,
    recurse => true,
    source  => 'puppet:///extra_files/hv-files',
  }
  if (!defined(File['/srv/nfs/hosts'])) {
    file {'/srv/nfs/hosts':
      ensure => directory,
    }
  }
  if (!defined(File['/srv/nfs/facter'])) {
    file {'/srv/nfs/facter':
      ensure  => directory,
      require => File['/srv/nfs/hosts'],
    }
  }
  exec {'facter':
    command => "/usr/bin/facter -py > /srv/nfs/facter/${hostname}.yaml",
    creates => "/srv/nfs/facter/${hostname}.yaml",
    require => File['/srv/nfs/facter'],
  }


# This provides the zuul and pip puppet modules that we use on our openstack work
  vcsrepo{'/opt/openstack-infra/config':
    ensure   => present,
    provider => git,
    source   => 'git://github.com/openstack-infra/config.git',
  }
  file {'/etc/puppet/modules/zuul':
    ensure  => link,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    target  => '/opt/openstack-infra/config/modules/zuul',
    require => Vcsrepo['/opt/openstack-infra/config'],
  }
  file {'/etc/puppet/modules/pip':
    ensure  => link,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    target  => '/opt/openstack-infra/config/modules/pip',
    require => Vcsrepo['/opt/openstack-infra/config'],
  }
  file {'/etc/puppet/modules/openstack_project':
    ensure  => link,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    target  => '/opt/openstack-infra/config/modules/openstack_project',
    require => Vcsrepo['/opt/openstack-infra/config'],
  }
  file {'/etc/puppet/modules/ssh':
    ensure  => link,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    target  => '/opt/openstack-infra/config/modules/ssh',
    require => Vcsrepo['/opt/openstack-infra/config'],
  }
  file {'/etc/puppet/modules/recheckwatch':
    ensure  => link,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    target  => '/opt/openstack-infra/config/modules/recheckwatch',
    require => Vcsrepo['/opt/openstack-infra/config'],
  }
  file {'/etc/puppet/modules/sudoers':
    ensure  => link,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    target  => '/opt/openstack-infra/config/modules/sudoers',
    require => Vcsrepo['/opt/openstack-infra/config'],
  }
  file {'/etc/puppet/modules/exim':
    ensure  => link,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    target  => '/opt/openstack-infra/config/modules/exim',
    require => Vcsrepo['/opt/openstack-infra/config'],
  }
  file {'/etc/puppet/modules/snmpd':
    ensure  => link,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    target  => '/opt/openstack-infra/config/modules/snmpd',
    require => Vcsrepo['/opt/openstack-infra/config'],
  }
  file {'/etc/puppet/modules/iptables':
    ensure  => link,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    target  => '/opt/openstack-infra/config/modules/iptables',
    require => Vcsrepo['/opt/openstack-infra/config'],
  }
  file {'/etc/puppet/modules/unattended_upgrades':
    ensure  => link,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    target  => '/opt/openstack-infra/config/modules/unattended_upgrades',
    require => Vcsrepo['/opt/openstack-infra/config'],
  }
  file {'/srv/install/kickstart':
    ensure  => directory,
    recurse => true,
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0644',
    source  => 'puppet:///extra_files/kickstart',
  }

# Packstack Controller and Neutron Node Pxe Files
  file {[
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-d4-85-64-44-63-c6',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-1c-c1-de-e8-9a-88']:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///extra_files/packstack-hp.pxe',
    require => Class['quartermaster'],
  }
# Packstack kvm node  Pxe Files
  file {[
## kvm-compute01
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-23-ae-fc-37-84',
## kvm-compute02
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-23-ae-fc-37-48',
## kvm-compute03
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-23-ae-fc-3f-08',
## kvm-compute04
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-22-19-d1-e8-dc',
## kvm-compute05
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-23-ae-fc-33-2c',
## kvm-compute06
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-23-ae-fc-37-a4',]:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///extra_files/packstack-dell.em1.pxe',
    require => Class['quartermaster'],
  }
## kvm-compute07
# Interface is eth0 and not em1
# Currently supplying a different kickstart
  file { '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-18-8b-ff-ae-5a':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///extra_files/packstack-dell.eth0.pxe',
    require => Class['quartermaster'],
  }
# Hyper-V compute Nodes, First 9 records for Rack1, Next 14 for Rack2
# Begin Rack 1
  file {[
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-d4-85-64-44-02-94',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-3c-4a-92-db-c8-8a',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-3c-4a-92-db-d8-a2',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-3c-4a-92-db-6d-dc',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-3c-4a-92-db-fd-c6',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-3c-4a-92-db-6d-cc',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-3c-4a-92-db-0e-2c',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-68-b5-99-c8-dc-1c',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-68-b5-99-c8-ed-e6']:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///extra_files/winpe.pxe',
    require => Class['quartermaster'],
  }

# Begin Rack 2
  file {[
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-1e-c9-bb-9e-82',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-1e-c9-bb-8a-9b',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-1e-c9-bb-88-cd',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-1e-c9-bb-a3-b3',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-1e-c9-bb-90-e9',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-1e-c9-bb-90-d4',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-1e-c9-bb-73-40',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-1e-c9-bb-9f-6c',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-1e-c9-bb-92-4f',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-1e-c9-bb-92-5e',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-1e-c9-bb-9e-46',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-1e-c9-bb-8d-c5',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-1e-c9-bb-90-1d',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-1e-c9-bb-91-ec']:
    ensure  => absent,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///extra_files/winpe.pxe',
    require => Class['quartermaster'],
  }
# End Rack 2

# Begin Rack 3
  file { [
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-1e-c9-bb-91-1c',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-1e-c9-d0-35-ad',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-22-19-27-10-e7',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-1e-c9-44-cb-0a',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-22-19-27-0f-51',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-1e-c9-d3-43-95',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-1e-c9-d0-34-36',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-1e-c9-d0-35-9e',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-1e-c9-d0-35-8a',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-1e-c9-d0-34-3b',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-1e-c9-d0-34-2c',
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-1e-c9-d0-35-c3']:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///extra_files/winpe.pxe',
    require => Class['quartermaster'],
  }
  
  file { [
    # kvm-compute08
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-1e-c9-d0-33-e1',
    # kvm-compute09
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-1e-c9-d0-35-ee',
    # kvm-compute10
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-22-19-27-0f-33',]:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///extra_files/packstack-dell.eth0.pxe',
    require => Class['quartermaster'],
  }
  file { [
    # sandbox01
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-18-8b-f8-bb-b7',
    # sandbox02
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-18-8b-f8-75-5e',
    # sandbox03
    '/srv/tftpboot/pxelinux/pxelinux.cfg/01-00-18-8b-f8-c0-01']:
    ensure  => absent,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    source  => 'puppet:///extra_files/packstack-dell.eth0.pxe',
    require => Class['quartermaster'],
  }

# End Rack 3 

  file { [
    '/srv/install/microsoft/winpe/system/menu/d4-85-64-44-02-94.cmd',
    '/srv/install/microsoft/winpe/system/menu/3c-4a-92-db-c8-8a.cmd',
    '/srv/install/microsoft/winpe/system/menu/3c-4a-92-db-d8-a2.cmd',
    '/srv/install/microsoft/winpe/system/menu/3c-4a-92-db-6d-dc.cmd',
    '/srv/install/microsoft/winpe/system/menu/3c-4a-92-db-fd-c6.cmd',
    '/srv/install/microsoft/winpe/system/menu/3c-4a-92-db-6d-cc.cmd',
    '/srv/install/microsoft/winpe/system/menu/3c-4a-92-db-0e-2c.cmd',
    '/srv/install/microsoft/winpe/system/menu/68-b5-99-c8-dc-1c.cmd',
    '/srv/install/microsoft/winpe/system/menu/68-b5-99-c8-ed-e6.cmd']:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => 'o:\hyper-v\2012r2\amd64\setup.exe /unattend:\\10.21.7.22\os\hyper-v\2012r2\unattend\hyper-v-2012r2-amd64.xml',
    require => Class['quartermaster'],
  }
# End Rack1
# Begin Rack2
  file { [
    '/srv/install/microsoft/winpe/system/menu/00-1e-c9-bb-9e-82.cmd',
    '/srv/install/microsoft/winpe/system/menu/00-1e-c9-bb-8a-9b.cmd',
    '/srv/install/microsoft/winpe/system/menu/00-1e-c9-bb-88-cd.cmd',
    '/srv/install/microsoft/winpe/system/menu/00-1e-c9-bb-a3-b3.cmd',
    '/srv/install/microsoft/winpe/system/menu/00-1e-c9-bb-90-e9.cmd',
    '/srv/install/microsoft/winpe/system/menu/00-1e-c9-bb-90-d4.cmd',
    '/srv/install/microsoft/winpe/system/menu/00-1e-c9-bb-73-40.cmd',
    '/srv/install/microsoft/winpe/system/menu/00-1e-c9-bb-9f-6c.cmd',
    '/srv/install/microsoft/winpe/system/menu/00-1e-c9-bb-92-4f.cmd',
    '/srv/install/microsoft/winpe/system/menu/00-1e-c9-bb-92-5e.cmd',
    '/srv/install/microsoft/winpe/system/menu/00-1e-c9-bb-9e-46.cmd',
    '/srv/install/microsoft/winpe/system/menu/00-1e-c9-bb-8d-c5.cmd',
    '/srv/install/microsoft/winpe/system/menu/00-1e-c9-bb-90-1d.cmd',
    '/srv/install/microsoft/winpe/system/menu/00-1e-c9-bb-91-ec.cmd']:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => 'o:\hyper-v\2012r2\amd64\setup.exe /unattend:\\10.21.7.22\os\hyper-v\2012r2\unattend\hyper-v-2012r2-amd64.xml',
    require => Class['quartermaster'],
  }
# End Rack2
# Begin Rack3
  file { [
    '/srv/install/microsoft/winpe/system/menu/00-1e-c9-bb-91-1c.cmd',
    '/srv/install/microsoft/winpe/system/menu/00-1e-c9-d0-35-ad.cmd',
    '/srv/install/microsoft/winpe/system/menu/00-22-19-27-10-e7.cmd',
    '/srv/install/microsoft/winpe/system/menu/00-1e-c9-44-cb-0a.cmd',
    '/srv/install/microsoft/winpe/system/menu/00-22-19-27-0f-51.cmd',
    '/srv/install/microsoft/winpe/system/menu/00-1e-c9-d3-43-95.cmd',
    '/srv/install/microsoft/winpe/system/menu/00-1e-c9-d0-34-36.cmd',
    '/srv/install/microsoft/winpe/system/menu/00-1e-c9-d0-34-9e.cmd',
    '/srv/install/microsoft/winpe/system/menu/00-1e-c9-d0-35-8a.cmd',
    '/srv/install/microsoft/winpe/system/menu/00-1e-c9-d0-34-3b.cmd',
    '/srv/install/microsoft/winpe/system/menu/00-1e-c9-d0-34-2c.cmd',
    '/srv/install/microsoft/winpe/system/menu/00-1e-c9-d0-35-c3.cmd']:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => 'o:\hyper-v\2012r2\amd64\setup.exe /unattend:\\10.21.7.22\os\hyper-v\2012r2\unattend\hyper-v-2012r2-amd64.xml',
    require => Class['quartermaster'],
  }
  file { [
    # Sandbox01 
    '/srv/install/microsoft/winpe/system/menu/00-18-8b-f8-bb-b7.cmd',
    # Sandbox02
    '/srv/install/microsoft/winpe/system/menu/00-18-8b-f8-75-5e.cmd',
    # Sandbox03 
    '/srv/install/microsoft/winpe/system/menu/00-18-8b-f8-c0-01.cmd']:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => 'o:\hyper-v\2012r2\amd64\setup.exe /unattend:\\10.21.7.22\os\hyper-v\2012r2\unattend\hyper-v-2012r2-amd64.xml',
    require => Class['quartermaster'],
  }
}

