node /^(hv-compute[0-9][0-9]).*/{
  notify {"Welcome ${fqdn}":}
  case $hostname {
    'hv-compute01':{
      class {'petools':}
    }
    default: { notify{"You're not hv-compute01":}}

  }
  class {'windows_common':}
  class {'windows_common::configuration::disable_firewalls':}
  class {'windows_common::configuration::enable_auto_update':}
  class {'windows_common::configuration::ntp':}

  class {'mingw':}

  class { 'openstack_hyper_v':
    # Services
    nova_compute              => true,
    # Network
    network_manager           => 'nova.network.manager.FlatDHCPManager',
    # Rabbit
    rabbit_hosts              => false,
    rabbit_host               => 'localhost',
    rabbit_port               => '5672',
    rabbit_userid             => 'guest',
    rabbit_password           => 'guest',
    rabbit_virtual_host       => '/',
    #General
    image_service             => 'nova.image.glance.GlanceImageService',
    glance_api_servers        => 'localhost:9292',
    instances_path            => 'C:\OpenStack\instances',
    mkisofs_cmd               => undef,
    qemu_img_cmd              => undef,
    auth_strategy             => 'keystone',
    # Live Migration
    live_migration            => false,
    live_migration_type       => 'Kerberos',
    live_migration_networks   => undef,
    # Virtual Switch
    virtual_switch_name       => 'br100',
    virtual_switch_address    => $::ipaddress_ethernet_2,
    virtual_switch_os_managed => true,
    # Others
    purge_nova_config         => true,
    verbose                   => false,
    debug                     => false
  }
#  class {'hyper_v::tools::create_vm':
#  }

}

