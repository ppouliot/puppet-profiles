
node 'logstash' {
# class {'zuul':}
  class {'basenode':}
  class {'sensu':}
  class {'sensu_client_plugins': require => Class['sensu'],}

  class {'python':
    dev => true,
    pip => true,
  }

#  class {'logstash': }
  class {'logstash_shim': 
    discover_nodes => ["${::fqdn}:9200"],
    require => Class['python'],
  }

  notify {"${hostname} -- WORK IN PROGRESS!":}
}
