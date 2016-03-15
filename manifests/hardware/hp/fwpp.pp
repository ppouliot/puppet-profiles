# == Class: profiles::hp::fwpp
class profiles::hp::fwpp {
  case $::virtual {
    'physical':{
      case $manufacturer {
        'HP':{
          case $osfamily:{
        }
      }
      default:{
        warning("!!! Virtual is set to ${::virtual} and must be physical")
      }
    }
  }
}
