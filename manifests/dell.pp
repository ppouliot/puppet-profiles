case $manufacturer {
  'Dell Inc.':{
#    include dell_openmanage
#    include basenode::ipmitools

    $msg_product = "${hostname} is a ${manufacturer} ${productname}"
    if $ipaddress =~ /([001-254\.])/{ 
      $octet1 => $1
      $octet2 => $2
      $octet3 => $3
      $octet4 => $4
    }

#    $default_ipmi_ipaddress = "$10.99.99.${octet4}",
#    exec {'ipmi-tool_dump_mac_addresses':
#      command   => 'ipmitool -H  $default_ipmi_address -U $ipmi_user -P ipmi_password delloem mac |grep [0-9]:',
#      logoutput => true
#      require   => Package['ipmi-tool'],
#    }
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
        notify {$msg_product:}
       # Insert M610 Classes here

      }
      'PowerEdge 2950': {
        warn($msg_product)
        notify {$msg_product:}
       # Insert 2950 Classes here
      }
      'PowerEdge R200': {
        warn($msg_product)
        notify {$msg_product:}
       # Insert R200 Classes here
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
