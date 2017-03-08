class profiles::munki ( $munki_http_root){

  case $osfamily {
    'Darwin':{
      $munki_user      = 'root'
      $munki_group     = 'wheel'
    }

    'Debian','RedHat':{
      $munki_src       = '/opt/munki'
      $munki_user      = 'www-data'
      $munki_group     = 'www-data'
      nginx::resource::location{'/munki_repo':
        ensure   => present,
        www_root => '/opt/',
        server    => $::fqdn,
        require => File["${munki_http_root}/munki_repo"],
        location_cfg_append => {
          autoindex => on
        },
      } ->
      file{[
        "${munki_http_root}/munki_repo/.README.html",
        "${munki_http_root}/munki_repo/catalogs/.README.html",
        "${munki_http_root}/munki_repo/manifests/.README.html",
        "${munki_http_root}/munki_repo/pkgs/.README.html",
        "${munki_http_root}/munki_repo/pkgsinfo/.README.html",
      ]:
        ensure   => file,
      }

      samba::server::share{'munki_repo':
        comment       => 'Managed Software Installation for OsX and MacOS Platforms',
        path          => "${munki_http_root}/munki_repo",
        guest_ok      => true,
        guest_account => 'nobody',
        read_only     => false,
      }
    }

    default:{
      warn("${::osfamily} isn't prepared for munki!")
    }
  }

  staging::file{'munkitools2-latest.pkg':
    source => 'https://munkibuilds.org/munkitools2-latest.pkg',
  }

  if $munki_src {
    vcsrepo{ $munki_src:
      ensure   => latest,
      source   => 'https://github.com/munki/munki',
      provider => git,
    }
  }

  file {[
    "${munki_http_root}/munki",
    "${munki_http_root}/munki_repo",
    "${munki_http_root}/munki_repo/catalogs",
    "${munki_http_root}/munki_repo/manifests",
    "${munki_http_root}/munki_repo/pkgs",
    "${munki_http_root}/munki_repo/pkgsinfo",
  ]:
    ensure => directory,
    owner  => $munki_user,
    group  => $munki_group,
    mode   => '0777',
  }

}
