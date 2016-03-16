#
# Begin Packstack nodes
##

node /^(openstack-controller).*/{
  class{'basenode':}
  class{'sensu':}
  class{'sensu_client_plugins': require => Class['sensu'],}
#  class{'basenode::dhcp2static':}  
  class{'jenkins::slave':
    executors => 60,
    masterurl => 'http://jenkins.openstack.tld:8080',
  }

  class {'packstack':
    openstack_release => 'havana',
    controller_host   => '10.21.7.41',
    network_host      => '10.21.7.42',
    kvm_compute_host  => '10.21.7.31,10.21.7.32,10.21.7.33,10.21.7.34,10.21.7.35,10.21.7.36,10.21.7.38',
  }

  vcsrepo {'/usr/local/src/openstack-imaging-tools':
    ensure   => present,
    provider => git,
    source   => 'git://github.com/cloudbase/windows-openstack-imaging-tools.git'
  }
  vcsrepo {'/usr/local/src/openstack-dev-scripts-ppouliot':
    ensure   => present,
    provider => git,
    source   => 'git://github.com/ppouliot/openstack-dev-scripts.git',
  }
  vcsrepo {'/usr/local/src/openstack-dev-scripts':
    ensure   => present,
    provider => git,
    source   => 'git://github.com/cloudbase/openstack-dev-scripts.git',
  }
  vcsrepo {'/usr/local/src/unattend-setup-scripts':
    ensure   => present,
    provider => git,
    source   => 'git://github.com/cloudbase/unattended-setup-scripts.git',
  }
  vcsrepo {'/usr/local/src/ci-overcloud-init-scripts':
    ensure   => latest,
    provider => git,
    source   => 'git://github.com/cloudbase/ci-overcloud-init-scripts.git',
    revision => 'master',
  }

  package {'pywinrm':
    ensure   => latest,
    provider => pip,
  }

}
node /^(neutron-controller).*/{
  class{'basenode':}
  class{'sensu':}
  class{'sensu_client_plugins': require => Class['sensu'],}
#  class{'basenode::dhcp2static':}  
  class{'jenkins::slave':
    masterurl => 'http://jenkins.openstack.tld:8080',
  }
  class{'packstack::yumrepo':}
}
# End Packstack nodes
