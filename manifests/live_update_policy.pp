class profiles::live_update_policy {
  include apt
  if $apt_has_updates == true {
    exec{"apt-dist-upgrade_and_purge_autoremove-${fqdn}":
      command   => '/usr/bin/apt-get update -y && apt-get dist-upgrade -y && apt-get --purge autoremove -y',
      logoutput => true,
      timeout   => '0',
      require   => Class['apt'],
    }
  }
}
