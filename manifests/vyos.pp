# Class profiles::vyos
#  Retrieves VyOS Images
#

class profiles::vyos (
  vyos_version                = '1.1.8',
  vyos_arch                   = ['amd64','i586']
  vyos_download_url           = "https:/downloads.vyos.io/release/${vyos_version}/
  vyos_ova                    = false,
  pia_openvpn_config_download = "https://www.privateinternetaccess.com/openvpn/openvpn-strong-tcp.zip"
  pia_config_extract_path     = '/tmp/staging/openpvn-strong-tcp'
){

  $vyos_arch.each | String $p_arch| {
    archive{"vyos-${vyos_version}-${p_arch}.iso":
      source => "https://downloads.vyos.io/release/${vyos_version}/vyos-${vyos_version}-${p_arch}.iso",
    }  
  }

  if $vyos_ova == true {
    archive{"vyos-${vyos_version}-amd64.ova":
      source => "https://downloads.vyos.io/release/${vyos_version}/vyos-${vyos_version}-amd64.ova",
    }
  }

  archive{".zip":
    source => $pia_openvpn_config_download,
    extract => true,
    extract_path => $pia_config_extract_path,
    creates =>[
      "${pia_config_extract_path}/AU Melbourne.ovpn",
      "${pia_config_extract_path}/AU Sydney.ovpn",
      "${pia_config_extract_path}/Brazil.ovpn",
      "${pia_config_extract_path}/CA North York.ovpn",
      "${pia_config_extract_path}/CA Toronto.ovpn",
      "${pia_config_extract_path}/ca.crt',
      "${pia_config_extract_path}/crl.pem',
      "${pia_config_extract_path}/Denmark.ovpn",
      "${pia_config_extract_path}/Finland.ovpn",
      "${pia_config_extract_path}/France.ovpn",
      "${pia_config_extract_path}/Germany.ovpn",
      "${pia_config_extract_path}/Hong Kong.ovpn",
      "${pia_config_extract_path}/India.ovpn",
      "${pia_config_extract_path}/Ireland.ovpn",
      "${pia_config_extract_path}/Israel.ovpn",
      "${pia_config_extract_path}/Italy.ovpn",
      "${pia_config_extract_path}/Japan.ovpn",
      "${pia_config_extract_path}/Mexico.ovpn",
      "${pia_config_extract_path}/Netherlands.ovpn",
      "${pia_config_extract_path}/New Zealand.ovpn",
      "${pia_config_extract_path}/Norway.ovpn",
      "${pia_config_extract_path}/Romania.ovpn",
      "${pia_config_extract_path}/Russia.ovpn",
      "${pia_config_extract_path}/Singapore.ovpn",
      "${pia_config_extract_path}/Sweden.ovpn",
      "${pia_config_extract_path}/Switzerland.ovpn",
      "${pia_config_extract_path}/Turkey.ovpn",
      "${pia_config_extract_path}/UK London.ovpn",
      "${pia_config_extract_path}/UK Southampton.ovpn",
      "${pia_config_extract_path}/US California.ovpn",
      "${pia_config_extract_path}/US East.ovpn",
      "${pia_config_extract_path}/US Florida.ovpn",
      "${pia_config_extract_path}/US Midwest.ovpn",
      "${pia_config_extract_path}/US New York City.ovpn",
      "${pia_config_extract_path}/US Seattle.ovpn",
      "${pia_config_extract_path}/US Silicon Valley.ovpn",
      "${pia_config_extract_path}/US Texas.ovpn",
      "${pia_config_extract_path}/US West.ovpn'
  	],
  }

}
