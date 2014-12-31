class profiles::hp {  
  $msg_product = "${hostname} is a ${manufacturer} ${productname}"
  case $virtual {
    'physical':{
      case $manufacturer {
        'HP':{
          case $productname {
            'ProLiant DL140 G3':{
              warn($msg_product)
            }
            'ProLiant SE326M1':{
              warn($msg_product)
            }
            'ProLiant SE316M1R2':{
              warn($msg_product)
            }
            default:{
              warn("this is an unknown HP product ${productname} in our infrastructure")
            }
          }
          default:{
            warn("!!! Manufacturer: ${manufacturer} is not HP")
          }
        }
      }
      default:{
            warn("!!! Virtual is set to ${virtual} and must be physical")
      }
    }
  }
}
