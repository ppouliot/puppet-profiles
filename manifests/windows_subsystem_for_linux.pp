class profiles::windows_subsystem_for_linux {

#   windowsfeature{'Microsoft-Windows-Subsystem-Linux': }
    dism{[
      'Microsoft-Windows-Subsystem-Linux',
      'NetFx3',
    ]:
      ensure  => present,
      require => Class['profiles::windows_enable_developer_mode']
    }

}
