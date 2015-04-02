
node /logs\d*/ {
#node 'logs' {
  class {'basenode':}
  class {'jenkins::slave':
    masterurl => 'http://jenkins.openstack.tld:8080',
  }
  class {'sensu':
    version => '0.12.6-1',
  }
  class{'sensu_client_plugins': require => Class['sensu'],}
  user {'logs':
    ensure     => present,
    comment    => 'log user',
    home       => '/home/logs',
    shell      => '/bin/bash',
    managehome => true,
  }
  file {'/srv/logs':
    ensure => directory,
    owner  => 'logs',
    group  => 'logs',
  }
 file { '/home/logs/.ssh':
    ensure  => directory,
    owner   => logs,
    group   => logs,
    mode    => 0600,
    require => User['logs'],
  }

 file { '/home/logs/.ssh/authorized_keys2':
    ensure  => file,
    owner   => logs,
    group   => logs,
    mode    => 0600,
    source  => "puppet:///extra_files/id_dsa.pub",
    require => User['logs'],
  }

  package {'git':
    ensure => present,
  }
 
  file { '/etc/cron.hourly/sync_logs_with_master':
    ensure => $::hostname ? {
      'logs'  => absent,
      default => file,
    },
    mode    => 755,
    content => '#!/bin/sh
rsync -aqze ssh logs:/srv/logs/ /srv/logs
',
  } 

  if ($::is_virtual == 'true') {
    notify{"This is a VM Logs host...": }

    package {'open-iscsi':
      ensure => latest,
    }
    file {'/etc/iscsi/iscsid.conf':
      ensure => present,
      require => Package['open-iscsi'],
    }
    exec {'disable-iscsi-manual':
      command => '/bin/sed -i "s/node.startup\ =\ manual/#\ node.startup\ =\ manual/g" /etc/iscsi/iscsid.conf',
      require => [Package['open-iscsi'],File['/etc/iscsi/iscsid.conf']],
      unless  => '/bin/grep -c "^#\ node.startup = manual" /etc/iscsi/iscsid.conf', 
    }
    exec {'enable-iscsi-automatic':
      command => '/bin/sed -i "s/#\ node.startup\ =\ automatic/node.startup\ =\ automatic/g" /etc/iscsi/iscsid.conf',
      require => Exec['disable-iscsi-manual'],
      unless  => '/bin/grep -c "^node.startup = automatic" /etc/iscsi/iscsid.conf', 
      notify  => Service['open-iscsi'],
    }
    service {'open-iscsi':
      ensure => running,
      require => Package['open-iscsi'],
    }
    exec {'iscsi-discovery-equallogic':
      command   => '/usr/bin/iscsiadm -m discovery -t st -p equallogic.openstack.tld',
      require   => [Package['open-iscsi'],
                    File['/etc/iscsi/iscsid.conf'],
                    Exec['enable-iscsi-automatic']],
      logoutput => true,
    }
    exec {'iscsi-login-equallogic':
      command   => '/usr/bin/iscsiadm -m node --login',
      require   => Exec['iscsi-discovery-equallogic'],
      logoutput => true,
      creates   => ['/etc/iscsi/nodes/iqn.2001-05.com.equallogic\:0-8a0906-dfe8e5504-d590000001452f3f-tempest-logs/10.21.7.251\,3260\,1/default',
                    '/dev/sda'],
    }
  
  
    file {'/etc/fstab':
      ensure => present,
    } -> 
    file_line {'tempest-logs':
      line => '/dev/mapper/log--storage-storage  /srv/logs       ext4    defaults,auto,_netdev 0 0',
      path => '/etc/fstab',
      require => [Exec['iscsi-login-equallogic'],File['/srv/logs']],
    }
    exec {'remount-iscsi-volume':
      command => '/bin/mount -a',
      require => File_line['tempest-logs'],
    }

  }  

  package {'apparmor-utils':
    ensure => latest,
  }
  
  service {'apparmor':
    ensure => running,
  }

  file { '/etc/apparmor.d/usr.sbin.nginx':
    ensure  => 'file',
    group   => '0',
    mode    => '644',
    owner   => '0',
    content => '# Last Modified: Mon Jan 13 12:09:16 2014
#include <tunables/global>

/usr/sbin/nginx {
  #include <abstractions/apache2-common>
  #include <abstractions/base>

  capability dac_override,
  capability setgid,
  capability setuid,

  /etc/nginx/conf.d/ r,
  /etc/nginx/conf.d/proxy.conf r,
  /etc/nginx/mime.types r,
  /etc/nginx/nginx.conf r,
  /etc/nginx/sites-available/logs.openstack.tld.conf r,
  /etc/nginx/sites-enabled/ r,
  /etc/ssl/openssl.cnf r,
  /run/nginx.pid rw,
  /srv/logs/ r,
  /srv/logs/** r,
  /usr/sbin/nginx mr,
  /var/log/nginx/access.log w,
  /var/log/nginx/error.log w,
  /var/log/nginx/logs.openstack.tld.access.log w,
  /var/log/nginx/logs.openstack.tld.error.log w,
}
',
    require => Class['nginx'],
    notify  => Service['apparmor'],
  }

  class {'nginx':}
#  nginx::config::nx_daemon_user = 'nginx'
  nginx::resource::vhost { 'logs.openstack.tld':
    www_root         => '/srv/logs',
    use_default_location => false,
    require          => User['logs'],
    vhost_cfg_append => {
      autoindex => on,
    }
  }
  nginx::resource::location{'/':
    ensure => present,
    www_root => '/srv/logs',
    vhost    => 'logs.openstack.tld',
  }
  nginx::resource::location{'~* "\.xml\.gz$"':
    ensure => present,
    www_root => '/srv/logs',
    vhost    => 'logs.openstack.tld',
    location_cfg_append => {
      add_header           => 'Content-Encoding gzip',
      gzip                 => 'off',
      types                => '{text/xml gz;}',
    }
  }

  nginx::resource::location{'~* "\.ini\.gz$"':
    ensure => present,
    www_root => '/srv/logs',
    vhost    => 'logs.openstack.tld',
    location_cfg_append => {
      add_header           => 'Content-Encoding gzip',
      gzip                 => 'off',
      types                => '{text/plain gz;}',
    }
  }
  nginx::resource::location{'~* "\.conf\.gz$"':
    ensure => present,
    www_root => '/srv/logs',
    vhost    => 'logs.openstack.tld',
    location_cfg_append => {
      add_header           => 'Content-Encoding gzip',
      gzip                 => 'off',
      types                => '{text/plain gz;}',
    }
  }
  nginx::resource::location{'~* "\.json\.gz$"':
    ensure => present,
    www_root => '/srv/logs',
    vhost    => 'logs.openstack.tld',
    location_cfg_append => {
      add_header           => 'Content-Encoding gzip',
      gzip                 => 'off',
      types                => '{text/plain gz;}',
    }
  }
  nginx::resource::location{'~* "\.yaml\.gz$"':
    ensure => present,
    www_root => '/srv/logs',
    vhost    => 'logs.openstack.tld',
    location_cfg_append => {
      add_header           => 'Content-Encoding gzip',
      gzip                 => 'off',
      types                => '{text/plain gz;}',
    }
  }
  
  nginx::resource::location{'~* "\.html\.gz$"':
    ensure => present,
    www_root => '/srv/logs',
    vhost    => 'logs.openstack.tld',
    location_cfg_append => {
      add_header           => 'Content-Encoding gzip',
      gzip                 => 'off',
      types                => '{text/html gz;}',
    }
  }
  nginx::resource::location{'~* "\.(log|txt)\.gz$"':
    ensure => present,
    www_root               => '/srv/logs',
    vhost                  => 'logs.openstack.tld',
    location_cfg_append => {
      add_header           => 'Content-Encoding gzip',
      gzip                 => 'off',
      types                => '{text/plain gz;}',
    }
  }
}

