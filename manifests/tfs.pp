# = Class: profiles::tfs
#
# Microsoft Visual Studio Team Explorer Everywhere 2010
# Download TFS Components
# https://www.microsoft.com/en-us/download/confirmation.aspx?id=4240
# https://www.microsoft.com/en-us/download/confirmation.aspx?id=4240&6B49FDFB-8E5B-4B07-BC31-15695C5A2143=1
class profiles::tfs () {
  validate_re($::kernel, '(^Linux|Windows)$', 'This Module only works on Linux and Windows Kernels.')
  $tfs_alert   = "Fullfilling ** TFS ** site requirements based on host ${::fqdn} detection of ${::kernel} kernel"
  $tfs_failure = "FAILURE: ${::kernel} failed to meet the requirements to operate in this site."

  case $kernel {
    'Linux':{
      notice( $tfs_alert )
      $tfs_location = '/opt/tfs'
      # Symlink to tf
      file {"${tfs_location}/TEE-CLC-10.0.0/tf":
        ensure  => link,
        target  => '/usr/local/bin/tf',
        require => Staging::Deploy['TEE-CLC-10.0.0.zip'],
      }
      # Symlink to wit
      file {"${tfs_location}/TEE-CLC-10.0.0/wit":
        ensure  => link,
        target  => '/usr/local/bin/wit',
        require => Staging::Deploy['TEE-CLC-10.0.0.zip'],
      }
    }

    'Windows':{
      notice( $tfs_alert )
      $tfs_location = 'C:/opt/tfs'
    }
    default:{
      fail($tfs_failure)
    }
  }

  file {$tfs_location:
    ensure => directory,
  }
  # TFS Eclipse Plugin
  staging::deploy{'TFSEclipsePlugin-UpdateSiteArchive-10.0.0.zip':
    source => 'http://download.microsoft.com/download/9/8/7/987D6B7C-F577-4297-8F60-E4B6A9EA4BF9/TFSEclipsePlugin-UpdateSiteArchive-10.0.0.zip',
    target => $tfs_location,
    require => File[$tfs_location],
  }
  # Microsoft Visual Studio Team Explorer Everywhere 2010
  staging::deploy{'TEE-CLC-10.0.0.zip':
    source => 'http://download.microsoft.com/download/9/8/7/987D6B7C-F577-4297-8F60-E4B6A9EA4BF9/TEE-CLC-10.0.0.zip',
    target => $tfs_location,
    require => File[$tfs_location],
  }
  staging::file{'InstallTEE.htm':
    target => $tfs_location,
    source => 'http://download.microsoft.com/download/9/8/7/987D6B7C-F577-4297-8F60-E4B6A9EA4BF9/InstallTEE.htm',
    require => File[$tfs_location],
  }
}
