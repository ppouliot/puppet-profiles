# == Class: profiles::active_directory_server
class profiles::active_directory_server {
case $::osfamily {
  'Windows':{
#node /(ad0.openstack.tld|ad1.openstack.tld|ad2.openstack.tld)/{
#  $ad_domain_password    = hiera('ad_passwd',{}),

  File {
    source_permissions => ignore,
  }

  class {'windows_common':}
  class {'windows_common::configuration::disable_firewalls':}
  class {'windows_common::configuration::enable_auto_update':}

  class {'windows_common::configuration::ntp':
    before => Class['windows_openssl'],
  }

  class{'windows_sensu':
    rabbitmq_password => 'sensu',
    rabbitmq_host     => '10.21.7.4',
    subscriptions     => ['ActiveDirectory'],
  }

  class {'windows_common::configuration::rdp':}
  class {'windows_openssl': }
  class {'windows_git': }
  class {'cloudbase_prep::wsman': require => Class['windows_openssl'],}
  class{'sensu_client_plugins': require => Class['windows_sensu'],}

  reboot {'prepare_system':
    apply => finished,
  }
  reboot {'ad_installed':
    apply => finished,
  }

  windows_common::configuration::feature { 'Server-Gui-Shell':
    ensure => absent,
    notify => Reboot['prepare_system'],
  }
  windows_common::configuration::feature { 'DNS':
    ensure => present,
    notify => Reboot['prepare_system'],
  }
  windows_common::configuration::feature { 'RSAT-DNS-Server':
    ensure => present,
    notify => Reboot['prepare_system'],
  }

  windows_common::configuration::feature { 'RSAT-AD-Tools':
    ensure => present,
    notify => Reboot['prepare_system'],
  }

  windows_common::configuration::feature { 'AD-Domain-Services':
    ensure  => present,
    require => Windows_common::Configuration::Feature['DNS','RSAT-DNS-Server'],
    notify  => Reboot['prepare_system'],
  }
  windows_common::configuration::feature { 'GPMC':
    ensure => present,
    notify => Reboot['prepare_system'],
  }
  # primary domain controller
  define profiles::primary_domain_controller ($ad_password) {
    notify{'I am the primary domain controller':} warning('I am the primary ad domain controller')
    class {'windows_domain_controller':
      domain       => 'forest',
      domainname   => $name,
      domainlevel  => '4',
      forestlevel  => '4',
      dsrmpassword => $ad_password,
      notify       => Reboot['ad_installed'],
    }
  }
  # additional domain controller
  define profiles::additional_domain_controller ($ad_admin,$ad_admin_password) {
      notify{'I am the secondary domain controller':} warning('I am the secondary domain controller')
      windows_common::domain::joindomain{$name:
        user_name => $ad_admin,
        password  => $ad_admin_password,
      }
#      class {'domain_membership':
#        domain   => 'ad.openstack.tld',
#        username => 'administrator',
#        password => 'P@ssw0rd',
#        force    => true,
#        notify   => Reboot['prepare_system'],
#      }
#      class {'windows_domain_controller::additional':
#        userdomain => 'ad.openstack.tld',
#        domainuser => 'administrator',
#        password   => 'P@ssw0rd',
#        notify     => Reboot['ad_installed'],
#      }
  }
#    'ad2.openstack.tld':{
#      notify{"I am the test domain controller":} warning('I am the test ad domain controller')
#      class {'windows_domain_controller':
#        domain      => 'forest',
#        domainname  => 'adtest.openstack.tld',
#        domainlevel => '4',
#        forestlevel => '4',
#        password    => 'P@ssw0rd',
#        notify      => Reboot['ad_installed'],
#      }
}

