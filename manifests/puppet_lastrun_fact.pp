# profiles::puppet_lastrun_fact
class profiles::puppet_lastrun_fact {

  file{'/etc/puppetlabs/facter/detect_puppet_lastrun.sh':
    ensure  => 'file',
    owner   => 'root',
    groupr  => 'root',
    mode    => '0777',
    source  => 'puppet:///modules/profiles/detect_puppet_lastrun.sh',
    require => File[
      '/etc/puppetlabs/facter',
      '/etc/puppetlabs/facter/facts.d'],
    }

  exec{'Generating Puppet LastRUN information':
    command => 'puppet lastrun info | sed \'s/^\ \ "/\ \ "lastrun_/g\' > /etc/puppetlabs/facter/facts.d/lastrun.json',
    require => Class['fetchfact'],
    onlyif  => '/etc/puppetlabs/facter/detect_puppet_lastrun.sh',
  }
}
