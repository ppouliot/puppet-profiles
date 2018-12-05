class profiles::cbs_ovs_hyperv {
  # OpenVSwitch for Windows
  # Install: 
  # msiexec /i openvswitch-hyperv.msi /l*v log.txt
  
  if $::kernel == 'windows' {
    $stg = 'C:/Windows/temp'
    archive{"${stg}/openvswitch-hyperv-installer-beta.msi":
      source => "https://www.cloudbase.it/downloads/openvswitch-hyperv-installer-beta.msi"
    }notice("${stg}/openvswitch-hyperv-installer-beta.msi")
    package{'Cloudbase Open vSwitch™ for Windows®':
      ensure          => installed,
      provider        => 'windows',
      source          => '${stg}/openvswitch-hyperv-installer-beta.msi', 
      install_options => ['/quiet','/passive'],
      require         => Archive["${stg}/openvswitch-hyperv-installer-beta.msi"],
	}
  }
}
