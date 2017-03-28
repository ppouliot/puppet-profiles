class profiles::puppetmaster (){
  # Disable IPv6 due to causing problem with PUPPETDB not starting on IPv4
  sysctl { 'net.ipv6.conf.all.disable_ipv6': value => '1' }
  sysctl { 'net.ipv6.conf.default.disable_ipv6': value => '1' }
  sysctl { 'net.ipv6.conf.lo.disable_ipv6': value => '1' }

  # PuppetDB Database Configuration
  class { 'puppetdb::database::postgresql':
    listen_addresses => $fqdn,
  } ->
  # PuppetDB Server Configuration
  class { 'puppetdb::server':
    listen_address => '0.0.0.0',
    database_host  => $fqdn,
    node_ttl          => '2d',
    node_purge_ttl    => '3d',
    report_ttl        => '3d',
    java_args      => {
      '-Xmx' => '1g',
    }
  } ->
  # Additional Postgresql role to begin to enable stream replication'
  postgresql::server::role { 'replication':
    password_hash => postgresql_password('replication', '$replication'),
  }

  class { 'puppetdb::master::config': }

  # OS Provided Gems
  package{'rspec-puppet-local':
    name => 'rspec-puppet',
    ensure => latest,
    provider => gem,
  }
  package{'hiera-eyaml-local':
    name => 'hiera-eyaml',
    ensure => latest,
    provider => gem,
  }
  # PuppetServer Path Ruby Gem Packages
  package {[
    'hiera-eyaml',
    'rspec-puppet',
  ]:
    ensure => latest,
    provider => puppetserver_gem,
  }
  # Additional Packages for Puppet Module Testing/Development Provided by the OS
  package {[
    'puppet-lint',
    'ruby-bundler',
    'vim-puppet',
  ]:
    ensure => latest,
  }

  file{'/root/bin':
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0770',
  } ->
  file{'/root/bin/stop_puppetdb_services.sh':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0770',
    content => "# This Script is Managed by in the
#Puppet Node Definition for ${fqdn}
#!/bin/bash
puppet resource service puppet ensure=stopped
puppet resource service puppetdb ensure=stopped
puppet resource service postgresql ensure=stopped
puppet resource service mcollective ensure=stopped
",
  } ->
  file{'/root/bin/start_puppetdb_services.sh':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0770',
    content => "# This Script is Managed by in the
#Puppet Node Definition for ${fqdn}
#!/bin/bash
puppet resource service puppet ensure=running
puppet resource service puppetdb ensure=running
puppet resource service postgresql ensure=running
puppet resource service mcollective ensure=running
",
  }

  # Apache Server Installation
  class { 'apache': }
  class { 'apache::mod::wsgi': }

 # PuppetBoard Web UI
  class { 'puppetboard':
    manage_git        => 'latest',
    manage_virtualenv => 'latest',
    enable_catalog    => true,
    enable_query      => true,
    reports_count     => '50',
  }
  # Apache Vhost for PuppetBoard Web UI
  class { 'puppetboard::apache::vhost':
    vhost_name => $::fqdn,
    port       => 80,
  }

}
