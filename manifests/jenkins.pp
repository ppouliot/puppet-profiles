# Jenkins
node /jenkins.*/ {
  # Set NTP
  class {'ntp':
    servers => ['bonehed.lcs.mit.edu'],
  }
  class {'basenode::ipmitools':}
#  include basenode::params
#  package {$nfs_packages:
#    ensure => latest,
#  }
#  create_resources(basenode::nfs_mounts,$nfs_mounts)
  package{'mailutils':
    ensure => present,
  }
  class {'sensu':}
  class{'sensu_client_plugins': require => Class['sensu'],}
    include jenkins
    jenkins::plugin {
      'swarm': ;
      'git':   ;
      'credentials':   ;
      'ldap':   ;
      'ssh-slaves':   ;
      'stackhammer':   ;
      'devstack':   ;
      'nodelabelparameter': ;
      'parameterized-trigger': ;

      #Additional plugins as identified by previous use
      'externalresource-dispatcher': ;
      'gearman-plugin': ;
      'git-client': ;
      'github-api': ;
      'github': ;
      'postbuild-task': ;
      'powershell': ;
      'jquery': ;
      'logging': ;
      'metadata': ;
      'python': ;
      'scm-api': ;
      'timestamper': ;
      'token-macro': ;

    }
# Build Tools

# FPM
# More Info: https://github.com/jordansissel/fpm
#
# Install fpm

  package {'fpm':
    ensure => installed,
    provider => 'gem',
  }

# Jenkins Job Builder
# Originating from Openstack-Infra
# Puppet module provided by Openstack-Hyper-V
#  class {'jenkins_job_builder':}

# Initial security settings.  May be adjusted later.
  $jenkinsconfig_path = '/var/lib/jenkins/'

  file { "${jenkinsconfig_path}config.xml":
    ensure  => link,
    target  => "${jenkinsconfig_path}users/config_base.xml",
	require => File["${jenkinsconfig_path}users"],
    owner   => 'jenkins',
  }

  file { "${jenkinsconfig_path}users":
    ensure  => directory,
    source  => "puppet:///extra_files/jenkins/users",
    recurse => remote,
    replace => false,
    purge   => false,
    owner   => 'jenkins',
  }

}

