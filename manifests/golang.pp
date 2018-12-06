# Install Golang
class profiles::golang {
  notice("Installing golang on ${::fqdn}")
  ensure_packages(['software-properties-common',{ ensure => latest, })
->apt::ppa{'ppa:gophers/archive':}
->ensure_packages(['golang-go',{ ensure => latest, })
}
