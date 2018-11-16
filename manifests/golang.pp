class profiles::golang {
  notice("Installing golang on ${::fqdn}")
  package{'software-properties-common':
    ensure => latest,
  }
->apt::ppa{'ppa:gophers/archive':}
->package{'golang-go':
    ensure => latest,
  }

}
