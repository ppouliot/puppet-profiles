# profiles::puppet_lastrun_fact
class profiles::puppet_lastrun_fact {

  case $::kernel {
    'Linux':{
      $local_facter_base_path = "/etc/facter"
    }

    'windows':{
      $local_facter_base_path = "C:/ProgramData/PuppetLabs/facter"
    }
    default:{
      $local_facter_base_path = "/etc/puppetlabs/facter"
    }
  }
  $local_fact_path = "${local_factor_base_path}/facts.d"

  file{"${local_facter_base_path}/detect_puppet_lastrun.sh":
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0777',
    source  => 'puppet:///modules/profiles/detect_puppet_lastrun.sh',
    require => Class['fetchfact'],
  } ->

  exec{'Generating Puppet LastRUN information':
    command => "${puppet_binary_path} lastrun info | sed \'s/^\ \ "/\ \ "lastrun_/g\' > ${local_fact_path}/lastrun.json",
    onlyif  => "${local_factor_base_path}/detect_puppet_lastrun.sh",
  }

}
