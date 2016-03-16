
node /dl\d*/ {
#node 'dl' {
  class {'basenode':}
  class {'sensu':
    version => '0.12.6-1',
  }
  class{'sensu_client_plugins': require => Class['sensu'],}
  user {'dl':
    ensure     => present,
    comment    => 'log user',
    home       => '/home/dl',
    shell      => '/bin/bash',
    managehome => true,
  }
  file {'/srv/dl':
    ensure => directory,
    owner  => 'dl',
    group  => 'dl',
  }
  file { '/home/dl/.ssh':
    ensure  => directory,
    owner   => 'dl',
    group   => 'dl',
    mode    => '0600',
    require => User['dl'],
  }
  file { '/home/dl/.ssh/authorized_keys2':
    ensure  => file,
    owner   => 'dl',
    group   => 'dl',
    mode    => '0600',
    source  => 'puppet:///extra_files/id_dsa.pub',
    require => User['dl'],
  }
  package {'git':
    ensure => present,
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
    mode    => '0644',
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
  /etc/nginx/sites-available/dl.openstack.tld.conf r,
  /etc/nginx/sites-enabled/ r,
  /etc/ssl/openssl.cnf r,
  /run/nginx.pid rw,
  /srv/dl/ r,
  /srv/dl/** r,
  /usr/sbin/nginx mr,
  /var/log/nginx/access.log w,
  /var/log/nginx/error.log w,
  /var/log/nginx/dl.openstack.tld.access.log w,
  /var/log/nginx/dl.openstack.tld.error.log w,
}
',
    require => Class['nginx'],
    notify  => Service['apparmor'],
  }
  class {'nginx':}
#  nginx::config::nx_daemon_user = 'nginx'
  nginx::resource::vhost { 'dl.openstack.tld':
    www_root             => '/srv/dl',
    use_default_location => false,
    require              => User['dl'],
    vhost_cfg_append     => {
      autoindex => on,
    }
  }
  nginx::resource::location{'/':
    ensure   => present,
    www_root => '/srv/dl',
    vhost    => 'dl.openstack.tld',
  }
  nginx::resource::location{'~* "\.xml\.gz$"':
    ensure              => present,
    www_root            => '/srv/dl',
    vhost               => 'dl.openstack.tld',
    location_cfg_append => {
      add_header => 'Content-Encoding gzip',
      gzip       => 'off',
      types      => '{text/xml gz;}',
    }
  }
  nginx::resource::location{'~* "\.ini\.gz$"':
    ensure              => present,
    www_root            => '/srv/dl',
    vhost               => 'dl.openstack.tld',
    location_cfg_append => {
      add_header => 'Content-Encoding gzip',
      gzip       => 'off',
      types      => '{text/plain gz;}',
    }
  }
  nginx::resource::location{'~* "\.conf\.gz$"':
    ensure              => present,
    www_root            => '/srv/dl',
    vhost               => 'dl.openstack.tld',
    location_cfg_append => {
      add_header => 'Content-Encoding gzip',
      gzip       => 'off',
      types      => '{text/plain gz;}',
    }
  }
  nginx::resource::location{'~* "\.json\.gz$"':
    ensure              => present,
    www_root            => '/srv/dl',
    vhost               => 'dl.openstack.tld',
    location_cfg_append => {
      add_header => 'Content-Encoding gzip',
      gzip       => 'off',
      types      => '{text/plain gz;}',
    }
  }
  nginx::resource::location{'~* "\.yaml\.gz$"':
    ensure              => present,
    www_root            => '/srv/dl',
    vhost               => 'dl.openstack.tld',
    location_cfg_append => {
      add_header => 'Content-Encoding gzip',
      gzip       => 'off',
      types      => '{text/plain gz;}',
    }
  }
  nginx::resource::location{'~* "\.html\.gz$"':
    ensure              => present,
    www_root            => '/srv/dl',
    vhost               => 'dl.openstack.tld',
    location_cfg_append => {
      add_header => 'Content-Encoding gzip',
      gzip       => 'off',
      types      => '{text/html gz;}',
    }
  }
  nginx::resource::location{'~* "\.(log|txt)\.gz$"':
    ensure              => present,
    www_root            => '/srv/dl',
    vhost               => 'dl.openstack.tld',
    location_cfg_append => {
      add_header => 'Content-Encoding gzip',
      gzip       => 'off',
      types      => '{text/plain gz;}',
    }
  }
}
