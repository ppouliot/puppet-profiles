class profiles::certbot_easydns {
  case $::osfamily {
    'debian':{
      $required_packages = 'software-properties-common'
      include apt
      apt::ppa{'ppa:certbot/certbot'}
    }
    'redhat':{
      include ::epel
    }
    default:{
      warning("Certbot may not be installed on ${::fqdn}!")
    }
  }
  # Install packages if not installed already

  ensure_packages({
    'dns-lexicon' => {
       provider => 'pip'
    },
    $required_packages,
    'certbot'},
    {'ensure' => 'latest'}
  )

  file{'/usr/local/bin/easydns_auth.sh':
    ensure  => file,
    content => '#!/bin/bash

lexicon easydns --auth-username="EASYDNS_API_TOKEN" --auth-token="EASYDNS_API_KEY" \

create "${CERTBOT_DOMAIN}" TXT --name "_acme-challenge.${CERTBOT_DOMAIN}" \

--content "${CERTBOT_VALIDATION}"



# tune sleep based on how long easyDNS updates take to apply to their nameservers

sleep 30
',
  }

 file{'/usr/local/bin/easydns_cleanup.sh':
    ensure  => file,
    content => '#!/bin/bash

lexicon easydns --auth-username="EASYDNS_API_TOKEN" --auth-token="EASYDNS_API_KEY" \

delete "${CERTBOT_DOMAIN}" TXT --name "_acme-challenge.${CERTBOT_DOMAIN}" \

--content "${CERTBOT_VALIDATION}"
',
  }

  file{'/usr/local/bin/certbot_easydns_auto-renew.sh':
    ensure  => file,
    content => '#!/usr/bin/env bash
certbot --manual --manual-auth-hook /usr/local/bin/easydns_auth.sh --manual-cleanup-hook /usr/local/bin/easydns_cleanup.sh --preferred-challenges=dns  --register-unsafely-without-email --agree-tos --manual-public-ip-logging-ok -d pouliot.net
',
  }



}
