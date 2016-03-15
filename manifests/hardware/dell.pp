class profiles::dell {
  case $manufacturer {
    'Dell Inc.':{
      $msg_product = "${hostname} is a ${manufacturer} ${productname}"
      case $productname {
        'PowerEdge M600': {
          warn($msg_product)
          # Insert M600 Classes or logic here
        }
  
        'PowerEdge M605': {
          warn($msg_product)
          # Insert M605 Classes or logic here
        }
  
        'PowerEdge M610': {
          warn($msg_product)
          # Insert M610 Classes here
        }
  
        'PowerEdge 860': {
          warn($msg_product)
          # Insert 860 Classes here
        }
  
        'PowerEdge 1950': {
          warn($msg_product)
          # Insert 1950 Classes here
        }
  
        'PowerEdge 2850': {
          warn($msg_product)
          # Insert 2850 Classes here
        }
  
        'PowerEdge 2950': {
          warn($msg_product)
          # Insert 2950 Classes here
        }
  
        'PowerEdge R200': {
          warn($msg_product)
          # Insert R200 Classes here
        }
  
        'PowerEdge R610': {
          warn($msg_product)
          # Insert R610 Classes here
        }
  
        'PowerEdge R710': {
          warn($msg_product)
          # Insert R710 Classes here
        }
  
        default:{
          warn("this is an unknown Dell product ${productname}")
        }
      }
  
    default:{
      warn("!!! Manufacturer: ${manufacturer} is not Dell Inc. !!!")
    }
  
  }
}
