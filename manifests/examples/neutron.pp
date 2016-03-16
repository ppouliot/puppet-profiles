#
#node /^(neutron-controller).*/{
node 'eth0-c2-r3-u18'{
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
