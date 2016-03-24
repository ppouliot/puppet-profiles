node 'zuul.openstack.tld'{
  class {'basenode':}
  # Temporary version lock on Sensu due to a compatibility issue between the puppet module and latest version.
  class {'sensu': version => '0.12.6-1',}
  class {'sensu_client_plugins': require => Class['sensu'],}
  group {'zuul':
    ensure => 'present',
  }
  user {'zuul':
    ensure     => 'present',
    gid        => 'zuul',
    managehome => true,
  }
  ensure_resource('class', 'python', {'pip' => true,'dev' => true })
  $zuul_version = hiera('zuul_version','latest')
  package {'zuul':
    ensure   => $zuul_version,
    provider => pip,
    require  => Class['python']
  }

  file {'/var/lib/zuul':
    ensure => directory,
    owner  => 'zuul',
    group  => 'zuul',
    mode   => '0755',
  }

  vcsrepo { '/opt/zuul':
    ensure   => present,
    provider => git,
    revision => '4561fa6e7266c094e4ac8c949929e5ec998af2ae',
    source   => 'https://git.openstack.org/openstack-infra/zuul',
  }

  file { '/var/lib/zuul/www':
    ensure  => directory,
    owner   => 'zuul',
    group   => 'zuul',
    mode    => '0755',
    require => File['/var/lib/zuul'],
  }

  package { 'libjs-jquery':
    ensure => present,
  }

  file { '/var/lib/zuul/www/jquery.min.js':
    ensure  => link,
    target  => '/usr/share/javascript/jquery/jquery.min.js',
    require => [File['/var/lib/zuul/www'],
                Package['libjs-jquery']],
  }

  vcsrepo { '/opt/jquery-visibility':
    ensure   => present,
    provider => git,
    revision => '62512a09c616040b76ca243ff4b43385a54f7efb',
    source   => 'https://github.com/mathiasbynens/jquery-visibility.git',
  }

  #file { '/var/lib/zuul/www/jquery-visibility.min.js':
  #  ensure  => link,
  #  target  => '/opt/jquery-visibility/jquery-visibility.min.js',
  #  require => [File['/var/lib/zuul/www'],
  #              Vcsrepo['/opt/jquery-visibility']],
  #}

  package { 'yui-compressor':
    ensure => present,
  }

  exec { 'install-jquery-visibility':
    command     => 'yui-compressor -o /var/lib/zuul/www/jquery-visibility.min.js /opt/jquery-visibility/jquery-visibility.js',
    path        => 'bin:/usr/bin',
    refreshonly => true,
    subscribe   => Vcsrepo['/opt/jquery-visibility'],
    require     => [File['/var/lib/zuul/www'],
                    Package['yui-compressor'],
                    Vcsrepo['/opt/jquery-visibility']],
  }

  file { '/var/lib/zuul/www/index.html':
    ensure  => link,
    target  => '/opt/zuul/etc/status/public_html/index.html',
    require => File['/var/lib/zuul/www'],
  }

  file { '/var/lib/zuul/www/app.js':
    ensure  => link,
    target  => '/opt/zuul/etc/status/public_html/app.js',
    require => File['/var/lib/zuul/www'],
  }

  class {'nginx':}

  nginx::resource::vhost { 'zuul.openstack.tld':
    www_root             => '/var/lib/zuul/www',
    use_default_location => false,
    access_log           => '/var/log/nginx/zuul_access.log',
    error_log            => '/var/log/nginx/zuul_error.log',
    #location_cfg_append => { 'rewrite' => '^/status.json$ http://127.0.0.1:80/status.json' },
    vhost_cfg_append     => {
      autoindex => on,
    }
  }

  nginx::resource::location{'/':
    ensure   => present,
    www_root => '/var/lib/zuul/www',
    vhost    => 'zuul.openstack.tld',
    #fastcgi        => "127.0.0.1:9000",
    #fastcgi_param  => {
    # 'GIT_PROJECT_ROOT'    => '/var/lib/zuul/git/',
    # 'GIT_HTTP_EXPORT_ALL' => "",
    #}
  }

  file {'/var/log/zuul':
    ensure => directory,
    owner  => 'zuul',
    group  => 'zuul',
    mode   => '0700',
  }

  service {'zuul':
#    ensure => stopped,
    require => [File['/var/lib/zuul'],File['/var/log/zuul'],Package['zuul']],
  }

  file {'/root/.ssh/known_hosts':
    ensure => file,
    owner  => 'root',
    group  => 'root',
  }

  file_line {'Github_Host_Keys-1':
    path    => '/root/.ssh/known_hosts',
    require => File['/root/.ssh/known_hosts'],
    line    => '|1|aLQHzwtyviPoHSsRR7lpEZxIAZE=|YFgjt9m7qOSLOAKYxMnv/jwCXIg= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ=='
  }
  file_line {'Github_Host_Keys-2':
    path    => '/root/.ssh/known_hosts',
    require => File['/root/.ssh/known_hosts'],
    line    => '|1|89x4leB7e3hy79cw+yyHVH6XE/A=|+niJStZ4OaOJ55knnXhclnSGGLc= ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ=='
  
  }

  vcsrepo {'service-config':
    ensure   => 'latest',
    revision => 'master',
    path     => '/usr/local/src/service-config',
    source   => 'git@github.com:openstack-hyper-v/service-config.git',
    provider => 'git',
    user     => 'root',
    force    => true,
    notify   => Service['zuul'],
    before   => Service['zuul'],
    require  => File_line['Github_Host_Keys-1', 'Github_Host_Keys-2'],
  }

  file { '/etc/init.d/zuul':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0755',
    source  => '/usr/local/src/service-config/zuul-service/zuul',
    require => Vcsrepo['service-config'],
    before  => Service['zuul'],
  }

  file {'/etc/zuul':
    ensure  => link,
    force   => true,
    target  => "/usr/local/src/service-config/${hostname}",
    require => [Vcsrepo['service-config'],Package['zuul']],
    notify  => Service['zuul'],
  }

  file {'/home/zuul/.ssh/':
    ensure => directory,
    owner  => 'zuul',
    group  => 'zuul',
    mode   => '0700',
  }

  file { '/home/zuul/.ssh/id_rsa':
    ensure  => file,
    owner   => 'zuul',
    group   => 'zuul',
    mode    => '0700',
    source  => '/usr/local/src/service-config/zuul-keys/id_rsa',
    require => [Vcsrepo['service-config'],User['zuul'],File['/home/zuul/.ssh/']]
  }

  file { '/home/zuul/.ssh/hyper-v-ci.pub':
    ensure  => file,
    owner   => 'zuul',
    group   => 'zuul',
    mode    => '0700',
    source  => '/usr/local/src/service-config/zuul-keys/hyper-v-ci.pub',
    require => [Vcsrepo['service-config'],User['zuul'],File['/home/zuul/.ssh/']]
  }

  file { '/etc/cron.daily/rotate_zuul':
    ensure  => file,
    owner   => root,
    group   => root,
    mode    => '0755',
    content => '#!/bin/bash
LOGDIR="/var/log/zuul"
if [ -d "$LOGDIR" ]
then
        find "$LOGDIR" -type f -regex ".*\.log\..*-[0-9]+$" -exec gzip {} \;
fi
',
#    source  => "puppet:///modules/openstack_project/zuul/rotate_zuul",
  }

notify {"${hostname} -- WORK IN PROGRESS!":}
}
