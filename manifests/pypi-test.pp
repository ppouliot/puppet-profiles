node 'eth0-c2-r3-u30' {
  $mirror_dir = "/opt/pypi-mirror";
  $pypi_port = '80',
  $pypi_root = '/var/pypi/web',

  package{"mercurial":
     ensure => latest,
  }
  
  vcsrepo { "${mirror_dir}":
    ensure   => present,
    provider => hg,
    source   => 'https://bitbucket.org/yamatt/pep381client',
    require  => Package["mercurial"],
  }

  file { '/var/pypi':
    ensure  => directory,
    recurse => true,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
  }

  exec{"install-mirror":
    command     => "python setup.py install",
    cwd         => "${mirror_dir}",
    path        => "/bin:/usr/bin",
    subscribe   => Vcsrepo["${mirror_dir}"],
  }

#  file { "/var/pypi/populate_done.txt":
#    ensure      => absent,
#    owner       => 'root',
#    group       => 'root',
#    mode        => '0755',
#    subscribe   => Exec["install-mirror"],
#    before      => [File["/var/pypi/pypi_populate.txt"],Exec["populate"]],
#  }

#  file { "/var/pypi/pypi_populate.txt":
#    ensure      => file,
#    owner       => 'root',
#    group       => 'root',
#    mode        => '0755',
#    subscribe   => Exec["install-mirror"],
#    content     => "/usr/bin/pep381run /var/pypi;touch /var/pypi/populate_done.txt",
#  }

#  exec { "populate":
#     command     => "at now + 5 minutes -f /var/pypi/pypi_populate.txt",
#     path        => "/usr/bin:/bin",
#     require     => File["/var/pypi/pypi_populate.txt"],
#     subscribe   => Exec["install-mirror"],
#     refreshonly => true,
#  }

  cron { 'mirror_pypi':
    command  => "/usr/bin/pep381run -q /var/pypi",
    user     => root,
    hour     => '*',   
    minute   => '*/15',
#    require  => File["/var/pypi/populate_done.txt"]
  }

  class {'nginx':}
  nginx::resource::vhost { 'eth0-c2-r3-u30.openstack.tld':
    www_root             => $pypi_root,
    use_default_location => false,
    access_log           => '/var/log/nginx/pypi_access.log',
    error_log            => '/var/log/nginx/pypi_error.log',
    vhost_cfg_append => {
      autoindex => on,
    }
  }
    
  nginx::resource::location{'/':
    ensure => present,
    www_root => $pypi_root,
    vhost    => 'eth0-c2-r3-u30.openstack.tld',
  }

}
