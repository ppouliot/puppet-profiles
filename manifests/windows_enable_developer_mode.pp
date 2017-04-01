class profiles::windows10_enable_developer_mode {
    $RegistryKeyPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock"
    exec{'Windows10_Developer_Mode-Create_AppModelUnlock':
      provider => powershell
      command  => "if (-not(Test-Path -Path ${RegistryKeyPath})) { New-Item -Path ${RegistryKeyPath} -ItemType Directory -Force }",
    } ->
    exec{'Windows10_Developer_Mode-AddRegistryValueToEnableDeveloperMode':
      provider => powershell,
      command  => "New-ItemProperty -Path ${RegistryKeyPath} -Name AllowDevelopmentWithoutDevLicense -PropertyType DWORD -Value 1",
    } ->

#   windowsfeature{'Microsoft-Windows-Subsystem-Linux': }
    dism{[
      'Microsoft-Windows-Subsystem-Linux',
      'NetFx3',
    ]:
      ensure => present,
    }

}
