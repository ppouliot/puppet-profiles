# profiles::puppet_lastrun_fact
class profiles::puppet_lastrun_fact {

  case $::kernel {

    'Linux':{
      $local_facter_base_path = '/etc/facter'
      $puppet_command = '/usr/local/bin/puppet'
      $detect_script = 'detect_puppet_lastrun.sh'

      File{
        owner   => 'root',
        group   => 'root',
      }

      Exec{
#       command => "${puppet_command} lastrun info | sed \'s/^\ \ \"/\ \ \"lastrun_/g\' > ${local_facter_base_path}/facts.d/lastrun.json",
        onlyif  => "${local_facter_base_path}/${detect_script}",
      }

    }

    'windows':{
      $local_facter_base_path = 'C:/ProgramData/PuppetLabs/facter'
      $puppet_command = 'C:/Program Files/Puppet Labs/Puppet/puppet/bin/puppet'
      $detect_script = 'detect_puppet_lastrun.ps1'

      Package { provider => chocolatey, }
      package{'sed':
        ensure => latest,
      }

      File{
        owner   => 'Everyone',
        group   => 'Administrators',
      }

      Exec{
#       command => "${puppet_command} lastrun info | sed \'s/^\ \ \"/\ \ \"lastrun_/g\' > ${local_facter_base_path}/facts.d/lastrun.json",
#       onlyif  => "C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -file ${local_facter_base_path}/${detect_script}",
        onlyif  => file("${local_facter_base_path}/${detect_script}"),
        provider => 'powershell',
        require => Package['sed'],
      }

    }

    default:{
      $local_facter_base_path = "/etc/puppetlabs/facter"
      $puppet_command = '/usr/local/bin/puppet'
      $detect_script = 'detect_puppet_lastrun.sh'

      File{
        owner   => 'root',
        group   => 'root',
      }

      Exec{
#       command => "${puppet_command} lastrun info | sed \'s/^\ \ \"/\ \ \"lastrun_/g\' > ${local_facter_base_path}/facts.d/lastrun.json",
        onlyif  => "${local_facter_base_path}/${detect_script}",
      }
    }
  }

  file{"${local_facter_base_path}/${detect_script}":
    ensure  => 'file',
    mode    => '0777',
    source  => "puppet:///modules/profiles/${detect_script}",
    require => Class['fetchfact'],
  } ->

  exec{'Generating Puppet LastRUN information':
    command => "${puppet_command} lastrun info | sed \'s/^\ \ \"/\ \ \"lastrun_/g\' > ${local_facter_base_path}/facts.d/lastrun.json",
  }

}
