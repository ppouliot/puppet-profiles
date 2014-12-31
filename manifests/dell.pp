case $manufacturer {
  'Dell Inc.':{
    include dell_openmanage
    include basenode::ipmitools

    notify {"${hostname} is a Dell!":
    }
    if $ipaddress =~ /([001-254\.])/{ 
      $octet1 => $1
      $octet2 => $2
      $octet3 => $3
      $octet4 => $4
    }

    $default_ipmi_ipaddress = "$10.99.99.${octet4}",
    exec {'ipmi-tool_dump_mac_addresses':
      command   => 'ipmitool -H  $default_ipmi_address -U $ipmi_user -P ipmi_password delloem mac |grep [0-9]:',
      logoutput => true
      require   => Package['ipmi-tool'],
    }
    case $productname {
     
      $msg_product = "${hostname} is a ${manufacturer} ${productname}"

      'PowerEdge M600': {
        notify {$msg_product:}
       # Insert M600 Classes or logic here

      }

      'PowerEdge M605': {
        notify {$msg_product:}
       # Insert M605 Classes or logic here

      }

      'PowerEdge M610': {
        notify {$msg_product:}
       # Insert M610 Classes here

      }
      'PowerEdge 2950': {
        notify {$msg_product:}
       # Insert M610 Classes here
      }
      'PowerEdge R200': {
        notify {$msg_product:}
       # Insert M610 Classes here
      }


   }
