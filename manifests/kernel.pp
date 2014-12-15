# This file defines the node definitions
# for the kvm-compute, openstack-controller
# and neutron-controller nodes

# kvm compute
##
case $kernel {
  'Linux'{},
  'Windows'{},


node /^(kvm-compute-[0-9]+)/ {

  notify {"OpenStack Node: ${hostname}":}
  class {'basenode':}
  class {'basenode::dhcp2static':}
  class {'dell_openmanage':}
#  class {'dell_openmanage::firmware::update':}
#  class {'packstack::yumrepo':}
  class {'jenkins::slave':}
}

# Neutron Controller
##
node /^(neutron-controller).*/{
  class {'basenode':}
  class {'basenode::dhcp2static':}
  class {'jenkins::slave':}
}

# OpenStack Controller
##
node /^(openstack-controller).*/{
  notify {"OpenStack Node: ${hostname}":}
  class {'basenode':}
  class {'basenode::dhcp2static':}
  class {'jenkins::slave':}
  class {'packstack':
    openstack_release => 'havana',
    controller_host   => '10.21.7.37',
    network_host      => '10.21.7.40',
    kvm_compute_host  => '10.21.7.30,10.21.7.31,10.21.7.32,10.21.7.33,10.21.7.34,10.21.7.35,10.21.7.36'
  }

  vcsrepo {'/usr/local/src/openstack-imaging-tools':
    ensure   => present,
    provider => git,
    source   => 'git://github.com/cloudbase/windows-openstack-imaging-tools.git'
  }
  vcsrepo {'/usr/local/src/openstack-dev-scripts':
    ensure   => present,
    provider => git,
    source   => 'git://github.com/ppouliot/openstack-dev-scripts.git',
  }
  vcsrepo {'/usr/local/src/unattend-setup-scripts':
    ensure   => present,
    provider => git,
    source   => 'git://github.com/cloudbase/unattended-setup-scripts.git',
  }
}
