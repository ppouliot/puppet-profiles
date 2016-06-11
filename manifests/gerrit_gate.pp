# class profiles::gerrit_gate
# Gerrit installation using Nginx & httppasswd for 
# the default authentication method
class profiles::gerrit_gate {

  # Nginx Authentication proxy
  class{'nginx': } ->

  httpauth { 'admin':
    file      => '/etc/nginx/gerrit.htpasswd',
    password  => 'gerrit',
    realm     => 'realm',
    mechanism => basic,
    ensure    => present,
  }

  nginx::resource::vhost{ $ipaddress:
    proxy                => "http://${::ipaddress}:8080",
    proxy_set_header     => [
      'X-Forward-For $remote_addr',
      'Host $host'
    ],
    auth_basic           => 'Gerrit Code Review',
    auth_basic_user_file => '/etc/nginx/gerrit.htpasswd',
  }

  # Gerrit Filesystem and permissions
  file{[
    '/opt/gerrit',
    '/opt/gerrit/git']:
    ensure => directory,
    group  => 'gerrit',
    owner  => 'gerrit',
    mode   => '0755',
  }

  class{'staging':
    path => '/opt/staging',
  }

  staging::file{'gerrit-2.12.2.war':
    source => 'https://gerrit-releases.storage.googleapis.com/gerrit-2.12.2.war',
  }

  class{'gerrit':
    source            => '/opt/staging/gerrit-2.12.2.war',
    target            => '/opt/gerrit',
    auth_type         => 'http',
    database_backend  => 'mysql',
    database_hostname => '10.13.1.29',
    database_name     => 'puppetci_reviewdb',
    database_username => 'puppetci',
    database_password => 'hard24get',
    canonicalweburl   => "http://${::ipaddress}:8080/",
    require           => File['/opt/gerrit'],
  } ->

  gerrit::repository{[
    'puppet-dell_openmanage',
    'puppet-etc_puppet',
    'puppet-etc_puppetlabs',
    'puppet-Puppetfile_Env',
    'puppet-profiles',
    'puppet-quartermaster',
    'puppet-maas',
    'puppet-juju',
    'puppet-ipam',
    'puppet-packstack',
    'puppet-pf',
    'puppet-manifests',
    'puppet-cloudbase_prep',
    'puppet-iphawk',
    'puppet-openstack_hyper_v',
    'puppet-windows_common',
    'puppet-windows_containers',
    'puppet-windows_time',
    'puppet-windows_terminal_services',
    'puppet-windows_openssl',
    'puppet-windows_platform_facts',
    'puppet-windows_python',
    'puppet-sensu_server',
    'puppet-sensu_client_plugins',
    'puppet-jenkins_job_builder',
    'puppet-osticket',
    'puppet-windows_freerdp',
    'puppet-openwsman',
    'puppet-basenode',
    'puppet-windows_clustering',
    'puppet-hyper_v',
    'puppet-redis',
    'puppet-mingw',
    'puppet-visualcplusplus2008',
    'puppet-windows_sensu',
    'puppet-ceilometer_hyper_v',
    'puppet-nova_hyper_v',
    'puppet-cinder_hyper_v',
    'puppet-windows_git',
    'puppet-petools',
    'puppet-network_mgmt',
    'puppet-devstack',
    'puppet-gitlab',
    'puppet-gitlab_server',
    'puppet-docker',
    'puppet-windows_java',
    'puppet-windows_7zip',
    'puppet-windows_chrome',
    'puppet-notepadplusplus',
    'puppet-visualcplusplus2012',
    'puppet-visualcplusplus2010',
    'dockerfile-sentinel-all']:
  }

  exec{'gerrit_stop':
    command     => '/opt/gerrit/bin/gerrit.sh stop',
    cwd         => '/opt/gerrit',
    refreshonly => true,
  }

  exec{'gerrit_start':
    command     => '/opt/gerrit/bin/gerrit.sh start',
    cwd         => '/opt/gerrit',
    refreshonly => true,
  }

  exec{'gerrit_restart':
    command     => '/opt/gerrit/bin/gerrit.sh restart',
    cwd         => '/opt/gerrit',
    refreshonly => true,
  }

  exec{'gerrit_reindex_reset_gerrit_ownership':
    command     => '/usr/bin/java -jar /opt/gerrit/bin/gerrit.war \'reindex\' && /bin/chown -R gerrit.gerrit /opt/gerrit',
    cwd         => '/opt/gerrit',
    refreshonly => true,
    notify      => Exec['gerrit_reset_directory_ownership'],
    require     => Exec['gerrit_stop'],
    before      => Exec['gerrit_start'],
  }

  exec{'gerrit_reset_directory_ownership':
    command     => '/bin/chown -R gerrit.gerrit /opt/gerrit',
    cwd         => '/opt/gerrit',
    refreshonly => true,
    require     => Exec['gerrit_stop'],
    before      => Exec['gerrit_start'],
  }

}
