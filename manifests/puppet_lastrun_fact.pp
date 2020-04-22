# profiles::puppet_lastrun_fact
class profiles::puppet_lastrun_fact {

  case $::kernel {
    'Linux':{
      $local_facter_base_path = '/etc/facter'
      $puppet_command = '/usr/local/bin/puppet'
      $detect_script = "detect_puppet_lastrun.sh"
      File{
        owner   => 'root',
        group   => 'root',
      }
    }
    'windows':{
      $local_facter_base_path = 'C:/ProgramData/PuppetLabs/facter'
      $puppet_command = 'C:/Program Files/Puppet Labs/Puppet/puppet/bin/puppet'
      $detect_script = "detect_puppet_lastrun.ps1"
      File{
        owner   => 'Everyone',
        group   => 'Administrators',
      }
    }
    default:{
      $local_facter_base_path = "/etc/puppetlabs/facter"
      $puppet_command = '/usr/local/bin/puppet'
      $detect_script = "${local_facter_base_path}/detect_puppet_lastrun.sh"
      File{
        owner   => 'root',
        group   => 'root',
      }
    }
  }

  $local_fact_path = "${local_factor_base_path}/facts.d"

  file{"${local_facter_base_path}/${detect_script}":
    ensure  => 'file',
    mode    => '0777',
    source  => "puppet:///modules/profiles/${detect_script}",
    require => Class['fetchfact'],
  } ->

  exec{'Generating Puppet LastRUN information':
    command => "${puppet_command} lastrun info | sed \'s/^\ \ \"/\ \ \"lastrun_/g\' > ${local_fact_path}/lastrun.json",
    onlyif  => "${local_facter_base_path}/${detect_script}",
    require => Class['fetchfact'],
  }

}
