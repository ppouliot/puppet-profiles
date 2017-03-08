# https://answers.microsoft.com/en-us/windows/forum/windows_10-update/on-windows-10-update/614348af-9b8b-4c0b-a07d-3a728f1db80f

class profiles::windows_gem_https_fix {

  if $::kernel == 'windows' {

    staging::file{'GlobalSignRootCA.pem':
      source => 'https://raw.githubusercontent.com/rubygems/rubygems/master/lib/rubygems/ssl_certs/index.rubygems.org/GlobalSignRootCA.pem',
    } ->

    file{'C:\Program Files\Puppet Labs\Puppet\sys\ruby\lib\ruby\2.0.0\rubygems\ssl_certs\GlobalSignRootCA.pem':
      ensure  => file,
      source  => 'C:\ProgramData\staging\GlobalSignRootCA.pem',
    }

  }

}
