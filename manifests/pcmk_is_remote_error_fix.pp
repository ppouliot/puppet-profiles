#  == Class profiles::pcmk_is_remote_error_fix 
#  Currently this error occurs on Ubuntu systems due to the pacemaker module upstream.  This will help it find it in the correct location.
#
#  Error: Facter: error while resolving custom fact "pcmk_is_remote": No such file or directory - /usr/bin/systemctl
#  backtrace:
#  /opt/puppetlabs/puppet/cache/lib/facter/pcmk_is_remote.rb:5:in ``'
#  /opt/puppetlabs/puppet/cache/lib/facter/pcmk_is_remote.rb:5:in `block (2 levels) in <top (required)>'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/indirector/facts/facter.rb:35:in `call'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/indirector/facts/facter.rb:35:in `to_hash'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/indirector/facts/facter.rb:35:in `find'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/indirector/indirection.rb:194:in `find'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/configurer/fact_handler.rb:15:in `find_facts'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/configurer/fact_handler.rb:31:in `facts_for_uploading'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/configurer.rb:127:in `get_facts'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/configurer.rb:306:in `run_internal'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/configurer.rb:221:in `block in run'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/context.rb:65:in `override'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet.rb:306:in `override'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/configurer.rb:195:in `run'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/agent.rb:45:in `block (4 levels) in run'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/agent/locker.rb:21:in `lock'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/agent.rb:45:in `block (3 levels) in run'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/agent.rb:98:in `with_client'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/agent.rb:42:in `block (2 levels) in run'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/agent.rb:65:in `run_in_fork'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/agent.rb:41:in `block in run'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/application.rb:179:in `call'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/application.rb:179:in `controlled_run'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/agent.rb:39:in `run'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/application/agent.rb:353:in `onetime'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/application/agent.rb:331:in `run_command'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/application.rb:358:in `block in run'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/util.rb:662:in `exit_on_fail'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/application.rb:358:in `run'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/util/command_line.rb:132:in `run'
#  /opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/util/command_line.rb:72:in `execute'
#  /opt/puppetlabs/bin/puppet:5:in `<main>'
class profiles::pcmk_is_remote_error_fix {

    case $::osfamily {
      debian:{
        notice(" !!!! Remediation being applied to ${::fqdn }
*****************************************************************************************************************
Error: Facter: error while resolving custom fact pcmk_is_remote: No such file or directory - /usr/bin/systemctl
backtrace:
/opt/puppetlabs/puppet/cache/lib/facter/pcmk_is_remote.rb:5:in ``'
/opt/puppetlabs/puppet/cache/lib/facter/pcmk_is_remote.rb:5:in `block (2 levels) in <top (required)>'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/indirector/facts/facter.rb:35:in `call'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/indirector/facts/facter.rb:35:in `to_hash'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/indirector/facts/facter.rb:35:in `find'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/indirector/indirection.rb:194:in `find'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/configurer/fact_handler.rb:15:in `find_facts'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/configurer/fact_handler.rb:31:in `facts_for_uploading'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/configurer.rb:127:in `get_facts'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/configurer.rb:306:in `run_internal'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/configurer.rb:221:in `block in run'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/context.rb:65:in `override'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet.rb:306:in `override'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/configurer.rb:195:in `run'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/agent.rb:45:in `block (4 levels) in run'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/agent/locker.rb:21:in `lock'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/agent.rb:45:in `block (3 levels) in run'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/agent.rb:98:in `with_client'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/agent.rb:42:in `block (2 levels) in run'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/agent.rb:65:in `run_in_fork'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/agent.rb:41:in `block in run'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/application.rb:179:in `call'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/application.rb:179:in `controlled_run'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/agent.rb:39:in `run'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/application/agent.rb:353:in `onetime'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/application/agent.rb:331:in `run_command'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/application.rb:358:in `block in run'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/util.rb:662:in `exit_on_fail'
/opt/puppetlabs/puppet/lib/ruby/vendor_ruby/puppet/application.rb:358:in `run'
*******************************************************************************************************************
"
             )
        file{'/usr/bin/systemctl':
          ensure => link,
          source => '/bin/systemctl',
        }
      }
      default:{
        notice{" ${::fqdn} man not need this fix because we have only seen it on debian/ubuntu based systems." )
      } 
    }
}
