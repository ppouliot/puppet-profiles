node 'c2-r13-u27-n1.openstack.tld',
     'c2-r13-u27-n2.openstack.tld',
     'c2-r13-u27-n3.openstack.tld',
     'c2-r13-u27-n4.openstack.tld'{
  warning("${::fqdn} is a galera cluster node for misc infra!")
  class{'epel':} ->
  class{'selinux':
    mode => 'disabled', 
    type => 'targeted',
  } ->
  package{[
    'iptables-services',
    'screen',
  ]:
    ensure => latest,
  }
  file{'/root/bin':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0770',
  }
  class{'galera':
    galera_servers                => ['10.13.1.33','10.13.1.34','10.13.1.35','10.13.1.36'],
#    galera_master                 => '10.13.1.33',
    galera_master                 => 'c2-r13-u27-n4.openstack.tld',
    vendor_type                   => 'mariadb',
    root_password                 => 'mariadb',
    status_password               => 'mariadb',
#    bind_address                  => $::ipaddress_enp1s0,
    local_ip                      => $::ipaddress_enp1s0,
    configure_firewall            => false,
  }

  if $fqdn == 'c2-r13-u27-n1.openstack.tld' {
    notice("Using ${::fqdn} to load databases onto the cluster.")
    # CIMETRICS DB
    mysql::db { 'cimetricsdb':
      user     => 'cimetrics',
      password => 'cimetrics',
      host     => '%',
    }
    
  }

}

node 'c2-r13-u31-n1.openstack.tld',
     'c2-r13-u31-n2.openstack.tld'{
  warning("${::fqdn} is a haproxy node to loadbalance the galera infrastructure!")
  include ::haproxy
  haproxy::listen { 'galera':
    collect_exported => false,
    ipaddress        => $::ipaddress,
    ports            => '3306',
  }
  haproxy::balancermember { 'haproxy':
    listening_service => 'galera',
    ports             => '3306',
    server_names      => ['c2-r13-u27-n4', 'c2-r13-u27-n2','c2-r13-u27-n3','c2-r13-u27-n1'],
    ipaddresses       => ['10.13.1.33','10.13.1.34','10.13.1.35','10.13.1.36'],
    options           => 'check',
  }
}
node 'c2-r13-u31-n3.openstack.tld',
     'c2-r13-u31-n4.openstack.tld'{
  warning("${::fqdn} is a rabbitmq cluster node!")
  class { 'rabbitmq':
    config_cluster           => true,
    cluster_nodes            => ['c2-r13-u31-n3', 'c2-r13-u31-n4'],
    cluster_node_type        => 'ram',
    erlang_cookie            => 'OPENSTACK_HYPERV_CI',
    wipe_db_on_cookie_change => true,
  }

}
