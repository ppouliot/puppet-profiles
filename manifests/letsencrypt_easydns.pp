class profiles::letsencrypt_easydns {
  include ::letsencrypt
  ensure_packages(['dns-lexicon'], { 'provider' => 'pip', 'ensure' => 'latest' })
  ensure_packages(['dehydrated','dehydrated-hook-dns-tsig'], { 'ensure' => 'latest' })

  file{'/etc/letsencrypt/easydns_auth.sh':
    ensure  => file,
    content => '#!/bin/bash

lexicon easydns --auth-username="EASYDNS_API_TOKEN" --auth-token="EASYDNS_API_KEY" \

create "${CERTBOT_DOMAIN}" TXT --name "_acme-challenge.${CERTBOT_DOMAIN}" \

--content "${CERTBOT_VALIDATION}"



# tune sleep based on how long easyDNS updates take to apply to their nameservers

sleep 30
',
  }

 file{'/etc/letsencrypt/easydns_cleanup.sh':
    ensure  => file,
    content => '#!/bin/bash

lexicon easydns --auth-username="EASYDNS_API_TOKEN" --auth-token="EASYDNS_API_KEY" \

delete "${CERTBOT_DOMAIN}" TXT --name "_acme-challenge.${CERTBOT_DOMAIN}" \

--content "${CERTBOT_VALIDATION}"
',
  }

  file{'/etc/letsencrypt/certbot_easydns_auto-renew.sh':
    ensure  => file,
    content => '#!/usr/bin/env bash
certbot --manual --manual-auth-hook /etc/letsencrypt/easydns_auth.sh --manual-cleanup-hook /etc/letsencrypt/easydns_cleanup.sh --preferred-challenges=dns  --register-unsafely-without-email --agree-tos --manual-public-ip-logging-ok -d pouliot.net
',
  }



}
