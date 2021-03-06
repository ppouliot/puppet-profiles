# == Class: profiles::hp
class profiles::hp {

  $msg_product                   = "${::fqdn} is a ${::manufacturer} ${::productname}"
  $hyperv_minimimum_requirement  = "${::fqdn} has ${::memorysize} RAM and meets the minimum requirement for Hyper-V CI workloads"
  $kvm_minimimum_requirement     = "${::fqdn} has ${::memorysize} RAM meets the minimum requirement for KVM CI workloads"
  $kvm_insufficient_resources    = "${::fqdn} has insufficient resources for KVM CI workloads"
  $hyperv_insufficient_resources = "${::fqdn} has insufficient resources for Hyper-V CI workloads"

  case $::virtual {
    'physical':{
      case $::manufacturer {
        'HP':{
          case $::productname {

            'ProLiant DL140 G3':{
              notice($msg_product)
              warning("Default ::manufacturer IPMI User: admin Password: admin from ${::manufacturer}")

              #Basic memory size tests and notification
              ##
              case $::memorysize_mb {
                '19988.54':{
                  notice($::kvm_minimum_requirement)
                  notice($::hyperv_minimum_requirement)
                }
                '11674.64':{
                  notice($::kvm_minimum_requirement)
                  notice($::hyperv_minimum_requirement)
                }
                '7442.41':{
                  notice($::hyperv_minimum_requirement)
                  warning($::kvm_insufficient_resources)
                }

                '3829.62':{
                  notice($::hyperv_minimum_requirement)
                  warning($::kvm_insufficient_resources)
                }
                default:{ warning("not the appropriate memorysize ${::memorysize}")}
              }
              default:{ warning("not the appropriate productname ${::productname}")}
            }

            'ProLiant SE326M1':{
              notice($::msg_product)
            }

            'ProLiant SE316M1R2':{
              notice($::msg_product)
            }
            'ProLiant DL360 G6':{
              notice($msg_product)
            }
            'ProLiant DL580 G5':{
              notice($msg_product)
              $hp_spp_iso_latest = 'spp2014020b'
            }
            default:{
              warning("this is an unknown HP product ${::productname} in our infrastructure")
            }
          }
          default:{
            warning("!!! Manufacturer: ${::manufacturer} is not HP")
          }

        }
      }
      default:{
        warning("!!! Virtual is set to ${::virtual} and must be physical")
      }
    }
  }
}
