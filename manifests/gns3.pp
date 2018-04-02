# Class profiles::gns3
# Installs GNS and Retrieves Virtualbox Images
#

class profiles::gns3 (
  gns3_version = '2.1.4',
  gns3_vbox_download_url = "https://github.com/GNS3/gns3-gui/releases/download/v${gns3_version}/GNS3.VM.VirtualBox.${gns3_version}.zip"
  dynamips_version = '0.2.18',
){

  case $kernel {
    'Windows':{
      gns_install_file      = "GNS3-${gns3_version}-all-in-one.exe"
      dynamips_install_file = "dynamips.exe",
    }
    'Darwin':{
      gns_install_file      = "GNS3-${gns3_version}.dmg"
      dynamips_install_file = "dynamips-osx",

    }
    'Linux':{
     
      package{[
        'gns3-gui',
        'gns3-server',
      ]:
        ensure   => latest,
        provider => pip,
      }
    }
    default:{
      warning('Unsupported Kernel')
    }
  }

  staging::file{"GNS3.VM.VirtualBox.${gns3_version}.zip":
    source => $gns3_download_url,
  }

  # Download GNS3 Virtualbox VM

  staging::file{ $gns3_install_file:
    source => "https://github.com/GNS3/gns3-gui/releases/download/v${gns3_version}/${gns3_install_file}",
  }

  # Cisco IOS Emulation
  # Dynamips
  staging::file{ $dynamips_install_file:
    source => "https://github.com/GNS3/dynamips/releases/download/v${dynamips_version}/${dynamips_install_file}"
  }

   

}
