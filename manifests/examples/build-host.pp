node /^win-build-host[0-9]*\.openstack\.tld$/{
  case $kernel {
    'Windows':{
      class {'windows_common':}
      class {'windows_common::configuration::disable_firewalls':}
      class {'windows_common::configuration::disable_auto_update':}
      class {'windows_common::configuration::ntp':
        before => Class['windows_openssl'],
      }
      class{'windows_sensu':
        rabbitmq_password => 'sensu',
        rabbitmq_host     => '10.21.7.4',
      }
      class {'windows_common::configuration::rdp':}
      class {'windows_openssl': }
      class {'java': distribution => 'jre' }

      class {'mingw': }
      mingw::dependency { 'mingw32-gendef': }
      mingw::dependency { 'mingw32-pthreads-w32': }

      # temporary solution to force posix_ipc to be built with mingw headers and not python-dev headers
      file_line { 'quoted-include':
          path    =>  "${mingw::mgw_get_path}/mingw32/include/process.h",
          match   =>  '^[#]include\s+[<"]stdint\.h[>"]',
          line    =>  '#include "stdint.h"',
          require =>  Class['mingw'],
      }
      
      class {'windows_git':}
#      class {'visualcplusplus2008':}
      class {'swig':}
      class {'nasm':}
#      class {'windows_openssl': 
#          $openssl_path => 'C:\\pkg',
#      }
      class {'mysql_windows':}
      class {'mysql_connector_c_windows':}
      class {'svn_windows':}

#      class {'windows_git': before => Class['cloudbase_prep'],}
#      class {'cloudbase_prep': }
      class {'jenkins::slave':
        install_java      => false,
        require           => Class['java'],
        manage_slave_user => false,
        executors         => 1,
        labels            => 'win-build',
        masterurl         => 'http://jenkins.openstack.tld:8080',
      }
      class{'sensu_client_plugins': require => Class['windows_sensu'],}
      if !defined (Windows_python::Dependency['PyYAML']){
        windows_python::dependency{ 'PyYAML':
          type    => pip,
#          require => Class['cloudbase_prep'],
        }
      }

    }
    default:{
      notify{"${kernel} on ${fqdn} doesn't belong here":}
    }
  }

}

