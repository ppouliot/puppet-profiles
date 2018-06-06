class profiles::supermicro {

  $default_ipmi_username = 'ADMIN'
  $default_ipmi_passwd   = 'ADMIN'

  # http://www.supermicro.com/support/bios/firmware.aspx
  
  # Supermicro X10DRT-P
  notice('Supermicro X10DRT-P')

  # User Manual
  staging::file{'MNL-1542.pdf':
    source => 'http://www.supermicro.com/manuals/motherboard/C600/MNL-1542.pdf',
  } notice('Supermicro X10DRT-P User Manual MNL-1542.pdf')

  # BIOS Supermicro X10DRT-P
  staging::file{'X10DRT8_209.zip':
    source => 'ftp://ftp.supermicro.com/Bios/softfiles/4637/X10DRT8_209.zip',
  } notice('Supermicro X10DRT-P Bios Firmware arcive X10DRT8_209.zip')

  staging::file{'LP-X10DRT-P-PT-PIBF-PIBQ_BIOS_3.0a_release_notes.pdf':
    source => 'ftp://ftp.supermicro.com/Bios/softfiles/4637/LP-X10DRT-P-PT-PIBF-PIBQ_BIOS_3.0a_release_notes.pdf',
  } notice('Supermicro X10DRT-P Bios X10DRT8_209 release notes 4637/LP-X10DRT-P-PT-PIBF-PIBQ_BIOS_3.0a_release_notes.pdf')

  # X10_memory_config_guide.pdf
  staging::file{'X10_memory_config_guide.pdf':
    source => 'http://www.supermicro.com/support/resources/memory/X10_memory_config_guide.pdf'
  } notice('X10 Serises DP Motherboads Memory Configuration Guide')

  # BMC/IPMI Firmware for Supermicro X10DRT-P
  staging::file{'REDFISH_X10_366.zip':
    source => 'ftp://ftp.supermicro.com/Bios/softfiles/4640/REDFISH_X10_366.zip'
  } notice('Supermicro X10DRT-P BMC/IPMI Firmware  arcive REDFISH_X10_366.zip')

  staging::file{'LP-X10DRT-P-PT-PIBF-PIBQ_IPMI_3.66_release_notes.pdf':
    source => 'ftp://ftp.supermicro.com/Bios/softfiles/4640/LP-X10DRT-P-PT-PIBF-PIBQ_IPMI_3.66_release_notes.pdf',
  } notice('Supermicro X10DRT-P BMC/IPMI firmware release notes LP-X10DRT-P-PT-PIBF-PIBQ_IPMI_3.66_release_notes.pdf')

  # Windows Device Drivers

  # Aspeed AST2400/AST2500 Graphic Driver
  staging::file{'ASPEED.zip':
    source => 'ftp://ftp.supermicro.com/driver/VGA/ASPEED/ASPEED.zip',
  } notice('Aspeed AST2400/AST2500 Graphic Driver')

  # Intel PCH Driver(SATA)
  staging::file{'Intel_PCH_RAID_Romley_4.6.0.1048_Win.zip':
    source => 'ftp://ftp.supermicro.com/driver/SATA/Intel_PCH_RAID_Romley_RSTE/Windows/4.6.0.1048/Win.zip',
  } notice('Intel PCH Driver(SATA): Intel_PCH_RAID_Romley_RSTE/Windows/4.6.0.1048/Win.zip version:4.6.0.1048')

  # Intel PCH Driver(SCU)
  staging::file{'Intel_PCH_SCU_Romley_4.6.0.1048_Win.zip':
    source => 'ftp://ftp.supermicro.com/driver/SCU/Intel_PCH_SCU_Romley/Windows/4.6.0.1048/Win.zip',
  } notice('Intel PCH Driver(SCU): Intel_PCH_RAID_Romley_RSTE/Windows/4.6.0.1048/Win.zip version:4.6.0.1048')

  # Intel® X540 Dual port 10GBase-T
  staging::file{'PRO_v22.10.zip':
    source => 'ftp://ftp.supermicro.com/driver/LAN/Intel/PRO_v22.10.zip',
  } notice('Intel® X540 Dual port 10GBase-T PRO_v22.10.ziop version:22.10')

  # Intel Utility
  staging::file{'IATA_CD.exe':
    source => 'ftp://ftp.supermicro.com/driver/SATA/Intel_PCH_RAID_Romley_RSTE/Management/4.6.0.1048/IATA_CD.exe',
  } notice('Intel Utility IATA_CD.exe version:4.6.0.1048') }

  # Intel INF for C612
  staging::file{'Chipset_v10.1.2.80.zip':
    source => 'ftp://ftp.supermicro.com/driver/Intel_INF/Skylake_Series_Chipset/Chipset_v10.1.2.80.zip',
  } notice('Intel INF for C612 Chipset_v10.1.2.80.zip version:10.1.2.80')

  # SuperMicro Download Driver CD

  # CDR-X10_1.10_for_Intel_X10_platform.iso
  staging::file{'CDR-X10_1.10_for_Intel_X10_platform.iso':
    source => 'ftp://ftp.supermicro.com/CDR_Images/CDR-X10/CDR-X10_1.10_for_Intel_X10_platform.iso',
  } notice('SuperMicro Download Driver CD CDR-X10_1.10_for_Intel_X10_platform.iso')

  # CDR-X10_1.11_for_Intel_X10_platform.iso
  staging::file{'CDR-X10_1.11_for_Intel_X10_platform.iso':
    source => 'ftp://ftp.supermicro.com/CDR_Images/CDR-X10/CDR-X10_1.11_for_Intel_X10_platform.iso',
  } notice('SuperMicro Download Driver CD CDR-X10_1.11_for_Intel_X10_platform.iso')

}
