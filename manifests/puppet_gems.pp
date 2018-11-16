# Class: profiles::puppet_gems
#
class profiles::puppet_gems {
  notice("Installing Puppet related additional ruby gems on ${::fqdn}")
  package{[
    'msgpack',
    'CFPropertyList',
    'generate-puppetfile',
    'ra10ke',
    'hiera-eyaml',
    'slack-notifier',
    'minitar-cli',
    'puppet-lint',
    'puppet-lint-resource_reference_syntax',
    'puppet-lint-file_ensure-check',
    'puppet-lint-classes_and_types_beginning_with_digits-check',
    'puppet-lint-unquoted_string-check',
    'puppet-lint-appends-check',
    'puppet-lint-version_comparison-check',
    'puppet-lint-undef_in_function-check',
    'puppet-lint-trailing_comma-check',
    'puppet-lint-spaceship_operator_without_tag-check',
    'puppet-lint-leading_zero-check',
    'puppet-lint-empty_string-check',
    'puppet-lint-absolute_classname-check']:
  #  ensure          => present,
    ensure          => latest,
    provider        => gem,
  }
}
