# == profiles::docker_host
# The basics for systems running containers.
class profiles::docker_host(){

  warning("${::fqdn} is a puppet managed docker host configured by the profiles::docker_host class")
  class {'docker':
    tcp_bind    => 'tcp://0.0.0.0:4243',
    socket_bind => 'unix:///var/run/docker.sock',
  } ->

  file{'/root/dockerhost_remove_images.sh':
    ensure => file,
    mode   => '0777',
    source => 'puppet:///modules/profiles/dockerhost_remove_images.sh',
  }
  file{'/root/dockerhost_remove_stale_containers.sh':
    ensure => file,
    mode   => '0777',
    source => 'puppet:///modules/profiles/dockerhost_remove_stale_containers.sh',
  }

  file {'/root/docker_host_join_shipyard.sh':
    ensure => file,
    mode   => '0777',
    source => 'puppet:///modules/profiles/dockerhost_join_shipyard.sh',
  }

  case $::operatingsystem {
    'Ubuntu':{
      notice("Docker host ${::fqdn} is peparing Ubuntu Based containers")
      docker::image {'ubuntu':
        image_tag =>  ['trusty']
      }
    }
    'Centos':{
      notice("docker host ${::fqdn} is peparing Centos Based containers")
      docker::image{'centos':
        image_tag =>  ['centos7']
      }
    }
    default:{
      warning('The Profiles::Docker_Host module does not currently support this platform!')
    }
  }
}
