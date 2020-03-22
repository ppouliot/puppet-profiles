## Here is the actual fix.  Need to reimplement using this
## https://raw.githubusercontent.com/glennsarti/dev-tools/master/RubyCerts.ps1 

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
