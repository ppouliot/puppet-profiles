class profiles::puppet_developer {
  case $osfamily {
    'Debian':{}
    'Redhat':{}
    'Windows':{}
    'FreeBSD':{}
    default:{}
}
