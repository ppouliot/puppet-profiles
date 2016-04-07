# == Class profiles::docker_registry
#
# Instructions from here: 
# http://blog.docker.io/2013/07/how-to-use-your-own-registry/
#git clone https://github.com/docker/docker-registry.git
#cd docker-registry
#cp config_sample.yml config.yml
#pip install -r requirements.txt
#gunicorn --access-logfile - --log-level debug --debug \
#    -b 0.0.0.0:5000 -w 1 wsgi:application
class profiles::docker_registry(){

  vcsrepo{'/usr/local/src/docker-registry':
    ensure   => present,
    provider => git,
    source   => 'https://github.com/docker/docker-registry.git'
  }
  $docker_registry_prereq = ['build-essential','python-openssl','libevent-dev','python-pip','python-dev']

  package { $docker_registry_prereq:
    ensure => latest,
  }

  file {'/usr/local/src/docker-registry/config.yml':
    ensure  => file,
    source  => '/usr/local/src/docker-registry/config_sample.yml',
    require => Vcsrepo['/usr/local/src/docker-registry'],
  }

  exec {'pip-install-requirements':
    command     => '/usr/bin/pip install -r /usr/local/src/docker-registry/requirements.txt',
    cwd         => '/usr/local/src/docker-registry',
    require     => [Package[$docker_registry_prereq],Vcsrepo['/usr/local/src/docker-registry']],
    logoutput   => true,
    refreshonly => true,
    timeout     => 0,
  }
  package{'docker-registry':
    ensure   => installed,
    provider => 'pip',
  }
}
