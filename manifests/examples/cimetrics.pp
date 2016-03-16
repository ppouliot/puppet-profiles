node 'cimetrics' {
  cimetrics_root = '/opt/CIMetrics';
  class {'basenode':}
  class {'sensu':}
  class {'sensu_client_plugins': require => Class['sensu'],}
  firewall {'100 allow http':
    state  => ['NEW'],
    port   => '80',
    proto  => 'tcp',
    action => 'accept',
  }
  vcsrepo{$cimetrics_root:
    ensure   => present,
    provider => git,
    source   => 'git://github.com/gabloe/CIMetricsAggregator.git',
  }
  include apache
  class {'apache::mod::wsgi':
    wsgi_socket_prefix => '/var/run/wsgi'
    wsgi_python_path   => "${cimetrics_root}/statsproj/openstack_stats",
  }
  class {'apache::mod::php':}
  apache::vhost { 'cimetrics':
    priority            => '10',
    port                => '80',
    docroot             => "${cimetrics_root}/statsproj/openstack_stats",
    docroot_owner       => 'cimetrics',
    docroot_group       => 'cimetrics',
#    wsgi_script_aliases => {'/' => "${cimetrics_root}/statsproj/openstack_stats/openstack_stats/wsgi.py"},
    wsgi_process_group  => 'cimetrics',
    wsgi_daemon_process => 'cimetrics user=cimetrics group=cimetrics processes=1 threads=5 maximum-requests=500 umask=0007 display-name=wsgi-cimetrics inactivity-timeout=300',
  }

  include mysql
  class {'mysql::server':}

  package{'php':
    ensure => latest,
  }

  package{'django':
    ensure   => '1.6.5',
    provider => 'pip',
  }

  package{'ijson':
    ensure   => latest,
    provider => 'pip',
  }

  package{'mysql-devel':
    ensure => latest,
  }

  package{'mysql-libs':
    ensure => latest,
  }

  package{'python-devel':
    ensure => latest,
  }

  package{'mysql-python':
    ensure   => latest,
    provider => 'pip',
    requires => [Package['mysql-devel'], Package['python-devel'], Package['mysql-lib'],],
  }

  notify {"${hostname} -- WORK IN PROGRESS!":}
}
