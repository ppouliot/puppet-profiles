
node /^(frankenstein).*/{
  $graphical_admin = ['blackbox',
                      'ipmitool',
                      'freeipmi-tools', 
                      'tightvncserver', 
                      'freerdp',
                      'freerdp-x11',
                      'ubuntu-virt-mgmt']
  package {$graphical_admin:
    ensure => latest,
  }
#apt::ppa { 'ppa:dotcloud/lxc-docker': }
  class {'basenode':}
  class {'apt':}
#  class {'jenkins::slave':}
  class {'docker':}
  docker::pull{'ubuntu':}
  docker::pull{'centos':}
}
