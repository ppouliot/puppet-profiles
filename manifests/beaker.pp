# == Class: profiles::puppetlabs_beaker
# Puppetlabs Beaker Acceptance Testing Tool

class profiles::beaker(){
  # Beaker Gem Requrements

  package{[
    'make',
    'ruby-dev',
    'libxml2-dev',
    'libxslt1-dev',
    'g++',
    'zlib1g-dev']:
    ensure          => latest,
  } ->

  package{[
    'beaker',
    'beaker-answers',
    'beaker-facter',
    'beaker-hiera',
    'beaker-hostgenerator',
    'beaker-librarian',
    'beaker-pe',
    'beaker-puppet_install_helper',
    'beaker-rspec',
    'beaker-testmode_switcher',
    'beaker-windows',
    'beaker_spec_helper',
    'simp-beaker-helpers']:
    ensure          => latest,
    provider        => gem,
  }
  
  vcsrepo{'/usr/local/src/beaker':
    source   => 'https://github.com/puppetlabs/beaker',
    provider => git,
    ensure   => latest,
  }

}
