# profiles::puppet_binary_path_fact
class profiles::puppet_binary_path_fact {
  case $::kernel {

    'Linux':{
      $local_fact_path      = "/etc/facter/facts.d"
      $local_fact_extension = 'sh'
      $local_fact_content   = '# Puppet Managed Fact: puppet_binary_path
#!/usr/bin/env bash
PUPPET_BINARY_PATH=`which puppet`
echo "puppet_binary_path=$PUPPET_BINARY_PATH"'

      File{
        owner   => 'root',
        group   => 'root',
      }

    }

    'windows':{
      $local_fact_path = "C:/ProgramData/PuppetLabs/facter/facts.d"
      $local_fact_extension = 'ps1'
      $local_fact_content = '# Puppet Managed Fact: puppet_binary_path
$puppet_binary_path = Get-Command puppet | select -expandproperty Path
Write-Host  "puppet_binary_path=$puppet_binary_path"'

      File{
        owner   => 'Everyone',
        group   => 'Administrators',
      }

    }

    default:{
      $local_fact_path = "/etc/puppetlabs/facter"
      $local_fact_extension = 'sh'
      $local_fact_content   = '# Puppet Managed Fact: puppet_binary_path
#!/usr/bin/env bash
PUPPET_BINARY_PATH=`which puppet`
echo "puppet_binary_path=$PUPPET_BINARY_PATH"'

      File{
        owner   => 'root',
        group   => 'root',
      }

    }

  }

  # Create a Fact to detect the puppet binary path.  This will assist on the first puppet run.
  file{'puppet_binary_path':
    path    => "${local_fact_path}/puppet_binary_path.${local_fact_extension}",
    ensure  => 'file',
    mode    => '0777',
    content => $local_fact_content,
  }
}
