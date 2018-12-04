class profiles::coreos {
  case $::osfamily {
    'CoreOS':{
      notice("CoreOS:${fqdn} is now managed by puppet!")
      file{'/etc/puppetlabs':
        ensure  => directory,
        recurse => true,
      } ->
      file{[
        '/etc/puppetlabs/code',
        '/etc/puppetlabs/code/environments',
      ]:
        ensure => directory,
      } ->
      file{[
        '/etc/ansible',
      ]:
        ensure => directory,
      }
#      class { 'etcd':
#        listen_client_urls          => 'http://0.0.0.0:2379',
#        advertise_client_urls       => "http://${::fqdn}:2379,http://127.0.0.1:2379",
#        listen_peer_urls            => 'http://0.0.0.0:2380',
#        initial_advertise_peer_urls => "http://${::fqdn}:2380,http://127.0.0.1:2379",
#        initial_cluster             => [
#          "${::hostname}=http://${::fqdn}:2380",
#        ],
#      }

    }
    default:{
      notice("${fqdn} is not a CoreOS!")
    }
  }
