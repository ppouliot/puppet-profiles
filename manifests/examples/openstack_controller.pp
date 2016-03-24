class { 'openstack::controller':
  public_address       => '10.21.7.101',
  public_interface     => 'eth0',
  private_interface    => 'eth1',
  internal_address     => '192.168.101.10',
  floating_range       => '192.168.101.64/28',
  fixed_range          => '10.0.0.0/24',
  multi_host           => false,
  network_manager      => 'nova.network.manager.FlatDHCPManager',
  admin_email          => 'root@localhost',
  admin_password       => 'admin_password',
  cinder_db_password   => 'cinder_db_password',
  cinder_user_password => 'cinder_user_password',
  keystone_admin_token => 'keystone_admin_token',
  keystone_db_password => 'keystone_db_password',
  glance_user_password => 'glance_user_password',
  glance_db_password   => 'glance_db_password',
  nova_db_password     => 'nova_db_password',
  nova_user_password   => 'nova_user_password',
  rabbit_password      => 'rabbit_password',
  rabbit_user          => 'rabbit_user',
  secret_key           => '12345',
  neutron              => false,
}
