class profiles::windows_dev_node {
  notice("${::fqdn} is managed by a puppetmaster")
  case $::kernel {
    'windows':{
      class {'chocolatey':
        log_output              => true,
      }
      Package{ provider => chocolatey}
  	class{'windows_autoupdate':
  	  no_auto_update                      => '0',
  	  au_options                          => '4',
  	  scheduled_install_day               => '0',
  	  no_auto_reboot_with_logged_on_users => '1',
  	} ->
  	class{'windows_time':
  	  w_timezone   => 'Eastern Standard Time',
  	  w_ntp_server => 'pool.ntp.org',
  	} ->
  	class{'windows_firewall':
  	  ensure => 'running',
  	} ->
  	class{'windows_terminal_services':
  	  remote_access => enable,
  	}
    }
  }
#  package{'windows-adk-all':
#    ensure => latest,
#  }

  package {[
    'git',
    'wget',
    'curl',
    'rsync',
    'notepadplusplus',
    'putty',
    'winrar',
    'python',
    'python2',
    'google-chrome-x64',
    'Firefox',
    'jdk8',
    'jre8',
    'unzip',
#    '7zip',
  ]:
    ensure => latest,
    provider => chocolatey,
  }
  $windows_adk_for_windows_10_version_1703_url = 'https://go.microsoft.com/fwlink/p/?LinkId=845542'
  class{'petools':}
}
