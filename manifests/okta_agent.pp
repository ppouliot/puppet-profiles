class okta_ad_agent {
  $okta_ad_agent_version = '3.4.10'
  case $::osfamily {
    'Windows':{
      include chocolatey
      Package{ provider => chocolatey}
      class{'windows_autoupdate':
        no_auto_update                      => 0,
        au_options                          => 4,
        scheduled_install_day               => 0,
        no_auto_reboot_with_logged_on_users => 1,
      } ->
      class{'windows_time':
        w_timezone   => 'Eastern Standard Time',
        w_ntp_server => 'time-c.nist.gov',
      } ->
      class{'windows_firewall':
        ensure => 'running',
      } ->
      class{'windows_terminal_services':
        remote_access => enable,
      }
      package {[
        'git',
        'wget',
        'curl',
        'rsync',
        'notepadplusplus',
        'winrar',
        'google-chrome-x64',
        'Firefox',
        'dotnet4.6.2',
        'dotnet4.7',
      ]:
        ensure   => latest,
        provider => chocolatey,
      }
      windows_path{'C:\Program Files\Git\bin':
        ensure => present,
      } ->
    
      class{'staging':
        path    => 'C:/programdata/staging',
        owner   => 'Administrator',
        group   => 'Administrator',
        mode    => '0777',
        require => Package['unzip'],
      } ->
      acl{'c:\ProgramData\staging':
        permissions => [
          {
            identity => 'Administrator',
            rights   => ['full'],
          },
          {
            identity => 'Administrators',
            rights   => ['full'],
          },
        ],
        require     => Class['staging'],
      }
    
      staging::file{"OktaADAgentSetup-${okta_ad_agent_version}.exe":
        source => "https://oktakempf-admin.okta.com/static/ad-agent/OktaADAgentSetup-${okta_ad_agent_version}.exe",
      }

      package{'Okta AD Agent':
        ensure          => installed,
        provider        => 'windows',
        source          => "c:/programdata/staging/OktaADAgentSetup-${okta_ad_agent_version}.exe",
        install_options => [ '/Q', ],
      }
    }
    default:{
      warning('Okta AD Agent is for Windows OS Only')
    }
  }
}
