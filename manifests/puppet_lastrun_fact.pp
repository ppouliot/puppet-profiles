# profiles::puppet_lastrun_fact
class profiles::puppet_lastrun_fact {

  case $::kernel {
    'Linux':{
      $local_facter_base_path = '/etc/facter'
      $puppet_command = '/usr/local/bin/puppet'
      $detect_script = "detect_puppet_lastrun.sh"
      $detect_script_content = '#!/usr/bin/env bash
#
# puppet lastrun detect script (linux)
#

PUPPET_LASTRUN=$(puppet lastrun)
PUPPET_LASTRUN_RESPONSE="Error: 'lastrun' has no default action.  See \`puppet help lastrun\`."

# echo $PUPPET_LASTRUN
# echo $PUPPET_LASTRUN_RESPONSE

if [ "$PUPPET_LASTRUN" == "$PUPPET_LASTRUN_RESPONSE" ]; then
  echo "Good!"
  exit 0
else
  echo "Bad!"
  exit 1
fi
'
      File{
        owner   => 'root',
        group   => 'root',
      }
    }
    'windows':{
      $local_facter_base_path = 'C:/ProgramData/PuppetLabs/facter'
      $puppet_command = 'C:/Program Files/Puppet Labs/Puppet/puppet/bin/puppet'
      $detect_script = "detect_puppet_lastrun.ps1"
      $detect_script_content = '# puppet lastrun detect script (windows)
$puppet_lastrun = (puppet lastrun)
$puppet_lastrun_response = "Error: 'lastrun' has no default action.  See \`puppet help lastrun\`."

If ( "$puppet_lastrun"  -eq "$puppet_lastrun_response" ){
  echo "Good!"
  exit 0
} else {
  echo "Bad!"
  exit 1
}
'
      File{
        owner   => 'Everyone',
        group   => 'Administrators',
      }
    }
    default:{
      $local_facter_base_path = "/etc/puppetlabs/facter"
      $puppet_command = '/usr/local/bin/puppet'
      $detect_script = "${local_facter_base_path}/detect_puppet_lastrun.sh"
      $detect_script_content = '#!/usr/bin/env bash
PUPPET_LASTRUN=$(puppet lastrun)
PUPPET_LASTRUN_RESPONSE="Error: 'lastrun' has no default action.  See \`puppet help lastrun\`."

# echo $PUPPET_LASTRUN
# echo $PUPPET_LASTRUN_RESPONSE

if [ "$PUPPET_LASTRUN" == "$PUPPET_LASTRUN_RESPONSE" ]; then
  echo "Good!"
  exit 0
else
  echo "Bad!"
  exit 1
fi
'
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
    source  => 'puppet:///modules/profiles/detect_puppet_lastrun.sh',
    require => Class['fetchfact'],
  } ->

  exec{'Generating Puppet LastRUN information':
    command => "${puppet_command} lastrun info | sed \'s/^\ \ \"/\ \ \"lastrun_/g\' > ${local_fact_path}/lastrun.json",
    onlyif  => "${local_facter_base_path}/${detect_script}",
  }

}
