# Install Golang
class profiles::golang {
  notice("Installing golang on ${::fqdn}")
  ensure_packages(['software-properties-common'], {'ensure' => 'latest'})
  apt::ppa{'ppa:gophers/archive':
    require => Package['software-properties-common'],
  }
  ensure_packages(['golang-go'], {'ensure' => 'latest', require => Apt::Ppa['ppa:gophers/archive']})
}
