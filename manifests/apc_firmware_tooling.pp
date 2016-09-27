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
  # Security Handbook for APC Network Management Cards
  staging::file{'AKAR-7FVQ2W_R1_EN.pdf':
    source => 'http://www.apcmedia.com/salestools/AKAR-7FVQ2W/AKAR-7FVQ2W_R1_EN.pdf?sdirect=true',
  } ->
  # Security Handbook Network Enabled Devices AOS V.6.4.X
  staging::file{'LFLG-9VYK3D_R0_EN.pdf':
    source => 'http://www.apcmedia.com/salestools/LFLG-9VYK3D/LFLG-9VYK3D_R0_EN.pdf',
  } ->
  # Release Notes Metered and Switched (AP8xxx) Rack Power Distribution Unit (PDU) v6.4.0
  staging::file{'JSAI-8C4TL4_R8_EN.pdf'':
    source => 'http://www.apcmedia.com/salestools/JSAI-8C4TL4/JSAI-8C4TL4_R8_EN.pdf',
  } ->
  # Metered by Outlet with Switching Rack Power Distribution Unit (AP86XX) User Guide Firmware Version 5.X.X
  staging::file{'JSAI-8BQMER_R4_EN.pdf':
    source => 'http://www.apcmedia.com/salestools/JSAI-8BQMER/JSAI-8BQMER_R4_EN.pdf',
  } ->
  # Metered Rack Power Distribution Unit (AP88XX) User Guide Firmware Version 5.X.X
  staging::file{'JSAI-7WFQKR_R4_EN.pdf':
    source => 'http://www.apcmedia.com/salestools/JSAI-7WFQKR/JSAI-7WFQKR_R4_EN.pdf',
  } ->
  # Switched Rack Power Distribution (AP89XX) Unit User Guide Firmware Version 5.X.X
  staging::file{'JSAI-862KZR_R2_EN.pdf':
    source => 'http://www.apcmedia.com/salestools/JSAI-862KZR/JSAI-862KZR_R2_EN.pdf',
  } ->
  # Network Management Device IP Configuration Wizard v5.0.2 
  staging::file{'Device_IP_Configuration_Wizard.exe',
    source => 'ftp://restrict:Kop$74!@ftp.apc.com/restricted/hardware/nmcard/firmware/devipcfg_wiz/502/Device%20IP%20Configuration%20Wizard.exe',
  } ->
  # Network Management Card Security Wizard v 1.04
  staging::file{'SecWiz_1.04_Install.exe':
    source => 'ftp://restrict:Kop$74!@ftp.apc.com/restricted/hardware/nmcard/firmware/sec_wiz/104/SecWiz%201.04%20Install.exe',
  } ->
  # Switched and Metered Rack Power Distribution Unit Gen 2 (AP8xxx Series) Firmware Revision 5.1.6
  staging::file{'apc_hw05_aos519_rpdu2g516_bootmon102.exe':
    source => 'ftp://restrict:Kop$74!@ftp.apc.com/restricted/hardware/nmcard/firmware/rpdu2g/516/apc_hw05_aos519_rpdu2g516_bootmon102.exe',
  } ->
  # PowerNet MIB v4.1.9
  staging::file{'powernet419.mib':
    source => 'ftp://ftp.apc.com/apc/public/software/pnetmib/mib/419/powernet419.mib',
  } ->
  # AP8xxx Series Rack Power Distribution Unit Firmware Revision 6.4.0
  staging::file{'apc_hw05_aos640_rpdu2g640_bootmon108.exe':
    source => 'ftp://restrict:Kop$74!@ftp.apc.com/restricted/hardware/nmcard/firmware/rpdu2g/640/apc_hw05_aos640_rpdu2g640_bootmon108.exe',
  } ->
  exec{'extract_apc_apc_hw05_aos640_rpdu2g640_bootmon108.exe':
    command => 'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108.exe /auto',
    logoutput => true,
    creates => [
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108',
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108\pc_hw05_aos_640.bin',
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108\apc_hw05_bootmon_108.bin',
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108\apc_hw05_rpdu2g_640.bin',
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108\config.txt',
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108\FW_Upgrade_R2.exe',
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108\iplist.txt',
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108\winftp32.dll',
      'C:\Programdata\staging\apc_hw05_aos640_rpdu2g640_bootmon108\winftp32.lib'],
  }
}
