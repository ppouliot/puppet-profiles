class profiles::shipyard {
  notice("This Shipyard Host runs Production CI Containers and is managed by puppet")

  class {'docker':
    tcp_bind    => 'tcp://0.0.0.0:4243',
    socket_bind => 'unix:///var/run/docker.sock',
#    docker_users => [ 'jenkins','puppet' ],
  } -> 
#  class{'jenkins::slave':
#    masterurl => 'http:://moneypenny.openstack.tld:9000',
#    ui_user   => 'jenkins',
#    ui_pass   => 'jenkins',
#  }

  docker::image {'ubuntu':
    image_tag =>  ['trusty'],
    ensure    => latest,
  }
  docker::image{'msopenstack/sentinel-ubuntu_trusty':
    ensure    => latest,
  }
  docker::image{'msopenstack/sentinel-ubuntu_xenial':
    ensure    => latest,
  }
#  docker::image{'msopenstack/ci_metrics_aggregator':
#    ensure    => latest,
#  }


# Official Jenkins LTS Docker Image
#  docker::image{'library/jenkins':
#    image_tag =>  ['latest']
#  }

# Official Docker Registry Image
  docker::image{'library/registry':
    image_tag =>  '2',
  }

  file{'/root/docker_remove_images.sh':
    ensure  => file,
    mode    => '0777',
    source => 'puppet:///modules/profiles/dockerhost_remove_images.sh',
  }
  file{'/root/docker_remove_stale_containers.sh':
    ensure  => file,
    mode    => '0777',
    source => 'puppet:///modules/profiles/dockerhost_remove_stale_containers.sh',
  }
  file{'/root/deploy_shipyard.sh':
    ensure  => file,
    mode    => '0777',
    source => 'puppet:///modules/profiles/deploy_shipyard.sh',
  }
  file{'/root/update_shipyard.sh':
    ensure  => file,
    mode    => '0777',
    source => 'puppet:///modules/profiles/update_shipyard.sh',
  }
  file{'/root/remove_shipyard.sh':
    ensure  => file,
    mode    => '0777',
    source => 'puppet:///modules/profiles/remove_shipyard.sh',
  }

#  docker::run { 'jenkins-master':
#    image           => 'library/jenkins:latest',
#    image           => 'msopenstack/jenkins-master',
#    ports           => ['9000:8080','50000:50000'],
#    volumes         => ['/var/jenkins_home'],
#    hostname        => 'jenkins-master',
#    require         => User['jenkins'],
#    restart_service => true,
#  }
  docker::run { 'msopenstack-internal-registry':
    image           => 'library/registry:2',
    hostname        => 'msopenstack-internal-registry',
    ports           => ['5000:5000','8140:8140'],
    restart_service => true,
  }
#  docker::run { 'cim':
#    image           => 'msopenstack/ci_metrics_aggregator',
#    hostname        => 'cim',
#    ports           => ['80:80'],
#,'3006:3006','8000,8000','8001,8001'],
#    restart_service => true,
#    command         => '/bin/sh -c "while true; do /CIMetricsTool/bin/start-everything.sh; sleep 1; done"'
#  }
}
