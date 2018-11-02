# profiles::puppet_lastrun_fact
class profiles::puppet_lastrun_fact {

  file{'/etc/puppetlabs/facter/detect_puppet_lastrun.sh':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0777',
    source  => 'puppet:///modules/profiles/detect_puppet_lastrun.sh',
    require => Class['fetchfact'],
  } ->

  exec{'Generating Puppet LastRUN information':
    command => '/opt/puppetlabs/bin/puppet lastrun info | sed \'s/^\ \ "/\ \ "lastrun_/g\' > /etc/puppetlabs/facter/facts.d/lastrun.json',
    onlyif  => '/etc/puppetlabs/facter/detect_puppet_lastrun.sh',
  }

}
