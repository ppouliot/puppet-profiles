# == profiles::container_engine
# The basics for systems running containers.
class profiles::container_engine(
  $default_script_path,
){

  warning("${::fqdn} is a puppet managed container engine configured by the profiles::container_engine class.")
  

  case $kernel {
    'Linux':{

      default_script_path  = 'root'
      class {'docker':
        tcp_bind    => 'tcp://0.0.0.0:4243',
        socket_bind => 'unix:///var/run/docker.sock',
      } 
  }

  'Windows':{
      default_script_path  = 'C:/ProgramData'
  }
    default:{
      warning("$::fqdn does not meet the requirements currently.")
    }
  }

  file{"$default_script_path/dockerhost_remove_images.sh":
    ensure => file,
    mode   => '0777',
    source => 'puppet:///modules/profiles/dockerhost_remove_images.sh',
  }
  file{"$default_script_path/dockerhost_remove_stale_containers.sh":
    ensure => file,
    mode   => '0777',
    source => 'puppet:///modules/profiles/dockerhost_remove_stale_containers.sh',
  }

  file{"$default_script_path/docker_host_join_shipyard.sh":
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
      docker::image{'msopenstack/sentinel-ubuntu':
        image_tag =>  ['latest']
      }
    }
    'Centos':{
      notice("docker host ${::fqdn} is peparing Centos Based containers")
      docker::image{'centos':
        image_tag =>  ['centos7']
      }
      docker::image{'msopenstack/sentinel-centos':
        image_tag =>  ['latest']
      }
    }
    default:{
      warning('The Profiles::Docker_Host module does not currently support this platform!')
    }
  }
}
