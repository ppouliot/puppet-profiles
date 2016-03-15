## profiles::centos_6_yumrepo
## Define Yum Repositories for centos 6
class profiles::centos::6::yum_repositories{
  case $operatingsystem {
    'Centos':{
      yumrepo { 'C6.0-base':
        baseurl  => 'http://vault.centos.org/6.0/os/$basearch/',
        descr    => 'CentOS-6.0 - Base',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'C6.0-centosplus':
        baseurl  => 'http://vault.centos.org/6.0/centosplus/$basearch/',
        descr    => 'CentOS-6.0 - CentOSPlus',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'C6.0-contrib':
        baseurl  => 'http://vault.centos.org/6.0/contrib/$basearch/',
        descr    => 'CentOS-6.0 - Contrib',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'C6.0-extras':
        baseurl  => 'http://vault.centos.org/6.0/extras/$basearch/',
        descr    => 'CentOS-6.0 - Extras',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'C6.0-updates':
        baseurl  => 'http://vault.centos.org/6.0/updates/$basearch/',
        descr    => 'CentOS-6.0 - Updates',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'C6.1-base':
        baseurl  => 'http://vault.centos.org/6.1/os/$basearch/',
        descr    => 'CentOS-6.1 - Base',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'C6.1-centosplus':
        baseurl  => 'http://vault.centos.org/6.1/centosplus/$basearch/',
        descr    => 'CentOS-6.1 - CentOSPlus',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'C6.1-contrib':
        baseurl  => 'http://vault.centos.org/6.1/contrib/$basearch/',
        descr    => 'CentOS-6.1 - Contrib',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'C6.1-extras':
        baseurl  => 'http://vault.centos.org/6.1/extras/$basearch/',
        descr    => 'CentOS-6.1 - Extras',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'C6.1-updates':
        baseurl  => 'http://vault.centos.org/6.1/updates/$basearch/',
        descr    => 'CentOS-6.1 - Updates',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'C6.2-base':
        baseurl  => 'http://vault.centos.org/6.2/os/$basearch/',
        descr    => 'CentOS-6.2 - Base',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'C6.2-centosplus':
        baseurl  => 'http://vault.centos.org/6.2/centosplus/$basearch/',
        descr    => 'CentOS-6.2 - CentOSPlus',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'C6.2-contrib':
        baseurl  => 'http://vault.centos.org/6.2/contrib/$basearch/',
        descr    => 'CentOS-6.2 - Contrib',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'C6.2-extras':
        baseurl  => 'http://vault.centos.org/6.2/extras/$basearch/',
        descr    => 'CentOS-6.2 - Extras',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'C6.2-updates':
        baseurl  => 'http://vault.centos.org/6.2/updates/$basearch/',
        descr    => 'CentOS-6.2 - Updates',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'C6.3-base':
        baseurl  => 'http://vault.centos.org/6.3/os/$basearch/',
        descr    => 'CentOS-6.3 - Base',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'C6.3-centosplus':
        baseurl  => 'http://vault.centos.org/6.3/centosplus/$basearch/',
        descr    => 'CentOS-6.3 - CentOSPlus',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'C6.3-contrib':
        baseurl  => 'http://vault.centos.org/6.3/contrib/$basearch/',
        descr    => 'CentOS-6.3 - Contrib',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'C6.3-extras':
        baseurl  => 'http://vault.centos.org/6.3/extras/$basearch/',
        descr    => 'CentOS-6.3 - Extras',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'C6.3-updates':
        baseurl  => 'http://vault.centos.org/6.3/updates/$basearch/',
        descr    => 'CentOS-6.3 - Updates',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'C6.4-base':
        baseurl  => 'http://vault.centos.org/6.4/os/$basearch/',
        descr    => 'CentOS-6.4 - Base',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'C6.4-centosplus':
        baseurl  => 'http://vault.centos.org/6.4/centosplus/$basearch/',
        descr    => 'CentOS-6.4 - CentOSPlus',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'C6.4-contrib':
        baseurl  => 'http://vault.centos.org/6.4/contrib/$basearch/',
        descr    => 'CentOS-6.4 - Contrib',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'C6.4-extras':
        baseurl  => 'http://vault.centos.org/6.4/extras/$basearch/',
        descr    => 'CentOS-6.4 - Extras',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'C6.4-updates':
        baseurl  => 'http://vault.centos.org/6.4/updates/$basearch/',
        descr    => 'CentOS-6.4 - Updates',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'Xen4CentOS':
        baseurl  => 'http://mirror.centos.org/centos/$releasever/xen4/$basearch/',
        descr    => 'CentOS-$releasever - xen',
        enabled  => '1',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'base':
        descr      => 'CentOS-$releasever - Base',
        gpgcheck   => '1',
        gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=os',
      }
      yumrepo { 'c6-media':
        baseurl  => 'file:///media/CentOS/
              file:///media/cdrom/
              file:///media/cdrecorder/',
        descr    => 'CentOS-$releasever - Media',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
      }
      yumrepo { 'centosplus':
        descr      => 'CentOS-$releasever - Plus',
        enabled    => '0',
        gpgcheck   => '1',
        gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=centosplus',
      }
      yumrepo { 'contrib':
        descr      => 'CentOS-$releasever - Contrib',
        enabled    => '0',
        gpgcheck   => '1',
        gpgkey     => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-6',
        mirrorlist => 'http://mirrorlist.centos.org/?release=$releasever&arch=$basearch&repo=contrib',
      }
      yumrepo { 'debug':
        baseurl  => 'http://debuginfo.centos.org/6/$basearch/',
        descr    => 'CentOS-6 - Debuginfo',
        enabled  => '0',
        gpgcheck => '1',
        gpgkey   => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-Debug-6',
      }
    }
    default:{
      warning("this is not needed for your ${::operatingsystem}")
    }
}
