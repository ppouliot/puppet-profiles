class profiles::golang {
  notice("Installing golang on ${::fqdn}")
  apt::ppa{'ppa:gophers/archive':}
->package{'golang-go':
    ensure => latest,
  }

}
