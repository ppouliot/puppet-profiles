# profiles::puppet_lastrun_fact
class profiles::puppet_lastrun_fact {

  case $::kernel {
    'Linux':{
      $local_facter_base_path = "/etc/facter"
      File{
        owner   => 'root',
        group   => 'root',
      }
    }
    'windows':{
      $local_facter_base_path = "C:/ProgramData/PuppetLabs/facter"
      File{
        owner   => 'Administrator',
        group   => 'Administrators',
      }
    }
    default:{
      $local_facter_base_path = "/etc/puppetlabs/facter"
      File{
        owner   => 'root',
        group   => 'root',
      }
    }
  }
  $local_fact_path = "${local_factor_base_path}/facts.d"

  file{"${local_facter_base_path}/detect_puppet_lastrun.sh":
    ensure  => 'file',
    mode    => '0777',
    source  => 'puppet:///modules/profiles/detect_puppet_lastrun.sh',
    require => Class['fetchfact'],
  } ->

  exec{'Generating Puppet LastRUN information':
    command => 'puppet lastrun info | sed \'s/^\ \ "/\ \ "lastrun_/g\' > ${local_fact_path}/lastrun.json',
    onlyif  => "${local_factor_base_path}/detect_puppet_lastrun.sh",
  }

}
