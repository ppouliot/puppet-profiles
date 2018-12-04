class profiles::ansible {
  case $::osfamily {
    'Debian':{
      include apt
      apt::ppa{'ppa:ansible/ansible':}
    } 
    'Redhat':{
      case $operatingsystemmajrelease {
        '6','7','25','26':{
          yumrepo { "releases-ansible-${operatingsystem}-${operatingsystemmajrelease}":
            baseurl  => "https://releases.ansible.com/ansible/${operatingsystemmajrelease}",
            descr    => "Ansible Releases: ${operatingsystem} ${operatingsystemmajrelease} YUM Repository)",
            enabled  => '0',
            gpgcheck => '1',
            gpgkey   => 'http://releases.ansible.com/keys/RPM-GPG-KEY-ansible-release.pub',
          }
        }
        default:{
          failure("ansible: ${fqdn} is not supported ${operatingsystem} ${operatingsystemmajrelease}  release!")
        }
      }
    }
    default:{
      failure("ansible: ${fqdn} does not have ansible release package repository!")
    }
  } ->
  package{'ansible':
    ensure => latest,
  }

}
