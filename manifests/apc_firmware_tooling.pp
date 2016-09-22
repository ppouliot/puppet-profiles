class profiles::apc_firmware_tooling {
  class{'staging':
    path    => 'C:/programdata/staging',
    owner   => 'Administrator',
    group   => 'Administrator',
    mode    => '0777',
    require => Package['unzip'],
  } -> 

  acl{'c:\ProgramData\staging':
    permissions => [
      { identity => 'Administrator', rights => ['full'] },
      { identity => 'Administrators', rights => ['full'] },
    ],
    require     => Class['staging'],
  }

  staging::file{'apc_hw05_aos640_rpdu2g640_bootmon108.exe':
    source => 'ftp://restrict:Kop$74!@ftp.apc.com/restricted/hardware/nmcard/firmware/rpdu2g/640/apc_hw05_aos640_rpdu2g640_bootmon108.exe',
  } ->
  exec{'extract_apc_apc_hw05_aos640_rpdu2g640_bootmon108.exe':
    command => 'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108.exe /auto',
    logoutput => true,
    creates => [
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108',
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108\pc_hw05_aos_640.bin',
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108\apc_hw05_bootmon_108.bin'
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108\apc_hw05_rpdu2g_640.bin'
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108\config.txt',
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108\FW_Upgrade_R2.exe',
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108\iplist.txt',
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108\winftp32.dll',
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108\winftp32.lib'],
  }
}
