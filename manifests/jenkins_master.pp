class profiles::jenkins_master () {
#  class{'profiles::shipyard':}
  package{[
    # Light UI for Mgmt
    'blackbox','tightvncserver','xterm','virt-manager',
    # httpasswd file management tools
    'apache2-utils',
    # Beaker Requrements
    'bc','make','ruby-dev','libxml2-dev','libxslt1-dev','g++','zlib1g-dev',
    # Puppet Lint Syntax testing
    'puppet-lint',
    # Virtualbox/Vagrant
    'virtualbox','vagrant',
    # Additional Development Tools
    'jq',
  ]:
    ensure => 'latest'
  } 
  class{'nodejs':
    manage_package_repo       => false,
    nodejs_dev_package_ensure => 'present',
    npm_package_ensure        => 'present',
  } ->
  package{'azure-cli':
    ensure   => 'latest',
    provider => 'npm',
#    require  => Class['nodejs'],
  }



  class{'python':
#    pip     => 'present',
  } ->
  package{[
    # JJB
    'jenkins-job-builder',
    # JJW
    'jenkins-job-wrecker',
    # ansible
    'ansible',
  ]:
    ensure   => 'latest',
    provider => 'pip',
  }

  # Puppet-lint additional ruby gems
  package{[
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

  # Gem Tools
  package{[
    # Ruby toolkit for the github api
    'octokit',
    # Puppetlabs Beaker Acceptance Testing Tool
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

  Jenkins::Plugin{ version => 'latest', }

  class {'jenkins':
    version                              => 'latest',
    lts                                  => false,
    executors                            => 8,
    install_java                         => true,
    configure_firewall                   => true,
    config_hash                          => {
      'HTTP_PORT'                        => {'value' => '9000' }
    },
    user_hash => {
       'jenkins' => {
         'password' => 'jenkins',
         'email'    => 'jenkins@jenkins-master.rakops',
       },
    },
    plugin_hash                          => {
      'ace-editor'                          => {},
      'analysis-core'                       => {},
      'ant'                                 => {},
      'antisamy-markup-formatter'           => {},
      'authentication-tokens'               => {},
      'ansicolor'                           => {},
      'ansible'                             => {},
      'ansible-tower'                       => {},
      'async-http-client'                   => {},
      'apache-httpcomponents-client-4-api'  => {},
      'azure-commons'                       => {},
      'azure-credentials'                   => {},
      'azure-vm-agents'                     => {},
      'azure-slave-plugin'                  => { 'enabled' => false },
      'azure-publishersettings-credentials' => {},
      'azure-batch-parallel'                => {},
      'backup'                              => {},
      'branch-api'                          => {},
      'bouncycastle-api'                    => {},
      'build-alias-setter'                  => {},
      'build-blocker-plugin'                => {},
      'build-cause-run-condition'           => {},
      'build-env-propagator'                => {},
      'build-environment'                   => {},
#     'build-failure-analyzer'              => {},
      # Build flow is depreciated  for pipeline
#     'build-flow-extensions-plugin'        => { 'enabled' => false },
#     'build-flow-plugin'                   => { 'enabled' => false },
#     'build-flow-test-aggregator'          => { 'enabled' => false },
#     'build-flow-toolbox-plugin'           => { 'enabled' => false },
      # 
      'build-history-metrics-plugin'        => {},
      'build-keeper-plugin'                 => {},
      'build-line'                          => {},
      'build-metrics'                       => {},
      'build-monitor-plugin'                => {},
      'build-name-setter'                   => {},
      'build-pipeline-plugin'               => {},
      'build-requester'                     => {},
      'build-timeout'                       => {},
      'build-timestamp'                     => {},
      'build-view-column'                   => {},
#     'buildgraph-view'                     => {},
      'built-on-column'                     => {},
      'cvs'                                 => {},
      'cloud-stats'                         => {},
      'cloudbees-folder'                    => {},
      'copyartifact'                        => {},
      'copy-data-to-workspace-plugin'       => {},
      'compact-columns'                     => {},
      'command-launcher'                    => {},
      'config-file-provider'                => {},
      'configure-job-column-plugin'         => {},
      'console-column-plugin'               => {},
      'custom-job-icon'                     => {},
      'conditional-buildstep'               => {},
#     Credentials is already defined in base module
#     'credentials'                         => {},
      'credentials-binding'                 => {},
      'dashboard-view'                      => {},
      'database-mysql'                      => {},
      'database'                            => {},
      'deployment-notification'             => {},
      'display-url-api'                     => {},
      'docker-workflow'                     => {},
      'docker-slaves'                       => {},
      'docker-traceability'                 => {},
      'docker-plugin'                       => {},
      'docker-custom-build-environment'     => {},
      'docker-commons'                      => {},
      'docker-build-step'                   => {},
      'docker-build-publish'                => {},
      'docker-java-api'                     => {},
      'dockerhub-notification'              => {},
      'durable-task'                        => {},
      'envinject'                           => {},
      'envinject-api'                       => {},
      'ez-templates'                        => {},
      'gerrit'                              => {},
      'gerrit-trigger'                      => {},
      'github'                              => {},
      'github-api'                          => {},
      'git'                                 => {},
      'git-changelog'                       => {},
      'git-client'                          => {},
      'git-server'                          => {},
      'git-chooser-alternative'             => {},
      'git-notes'                           => {},
      'git-parameter'                       => {},
      'git-tag-message'                     => {},
      'git-userContent'                     => {},
      'github-branch-source'                => {},
      'github-issues'                       => {},
      'github-oauth'                        => {},
      'github-pullrequest'                  => {},
      'github-pr-comment-build'             => {},
      'github-pr-coverage-status'           => {},
      'global-build-stats'                  => {},
      'global-post-script'                  => {},
      'global-variable-string-parameter'    => {},
      'groovy'                              => {},
      'google-git-notes-publisher'          => {},
      'groovy-events-listener-plugin'       => {},
      'groovy-events-listener-plugin-master' => {},
      'groovy-label-assignment'             => {},
      'groovy-postbuild'                 => {},
      'groovy-remote'                    => {},
#      'groovyaxis'                       => { 'enabled' => false },
      'handlebars'                       => {},
      'hudson-wsclean-plugin'            => {},
      'icon-shim'                        => {},
      'jackson2-api'                        => {},
      'jenkins-multijob-plugin'          => {},
      'javadoc'                          => {},
      'jsch'                             => {},
      'junit'                            => {},
      'jquery'                           => {},
      'jquery-detached'                  => {},
      'job-dsl'                          => {},
      'job-restrictions'                 => {},
      'job-parameter-summary'            => {},
      'jobtemplates'                     => {},
      'jobtype-column'                   => {},
      'ldap'                             => {},
      'libvirt-slave'                    => {},
      'logging'                          => {},
      'mailer'                           => {},
# Disable due to error when retrieving
      'mapdb-api'                        => {},
      'matrix-auth'                      => {},
      'matrix-project'                   => {},
      'maven-plugin'                     => {},
      'mission-control-view'             => {},
      'modernstatus'                     => {},
      'momentjs'                         => {},
      'multiple-scms'                    => {},
      'mysql-job-databases'              => {},
      'nested-view'                      => {},
      'network-monitor'                  => {},
      'openstack-cloud'                  => {},
#      'openstack-heat'                   => {},
      'pam-auth'                         => {},
      'plain-credentials'                => {},
      'parallel-test-executor'           => {},
      'parameterized-trigger'            => {},
      'pipeline-aggregator-view'         => {},
      'pipeline-build-step'              => {},
      'pipeline-graph-analysis'          => {},
      'pipeline-github-lib'              => {},
      'pipeline-githubnotify-step'       => {},
      'pipeline-input-step'              => {},
      'pipeline-maven'                   => {},
      'pipeline-milestone-step'          => {},
      'pipeline-model-api'               => {},
      'pipeline-model-declarative-agent' => {},
      'pipeline-model-definition'        => {},
      'pipeline-model-extensions'        => {},
      'pipeline-multibranch-defaults'    => {},
      'pipeline-npm'                     => {},
      'pipeline-rest-api'                => {},
      'pipeline-stage-step'              => {},
      'pipeline-stage-tags-metadata'     => {},
      'pipeline-stage-view'              => {},
      'pipeline-utility-steps'           => {},
      'powershell'                       => {},
      'port-allocator'                   => {},
      'puppet'                           => {},
#      'postbuildscript'                  => { 'enabled' => false },
      'prereq-buildstep'                 => {},
      'project-build-times'              => {},
      'project-stats-plugin'             => {},
      'promoted-builds'                  => {},
      'python'                           => {},
      'run-condition'                    => {},
      'ruby-runtime'                     => {},
      'resource-disposer'                => {},
      'saferestart'                      => {},
      'saltstack'                        => {},
      'smart-jenkins'                    => {},
      'ssh-slaves'                       => {},
      'shared-workspace'                 => {},
      'ssh-credentials'                  => {},
      # SCP Plugin disabled due to security issue
#      'scp'                              => { 'enabled' => absent },
      'scm-api'                          => {},
      'sidebar-link'                     => {},
      'swarm'                            => {},
      'subversion'                       => {},
      'script-security'                  => {},
      'slave-prerequisites'              => {},
      'slave-proxy'                      => {},
      'slave-setup'                      => {},
      'slave-squatter'                   => {},
      'slave-status'                     => {},
      'slave-utilization-plugin'         => {},
#  Structs is now part of default module
#      'structs'                          => {},
      'stackhammer'                      => {},
      'started-by-envvar'                => {},
      'status-view'                      => {},
      'statusmonitor'                    => {},
      'systemloadaverage-monitor'        => {},
      'tasks'                            => {},
      'tfs'                              => {},
      'thinBackup'                       => {},
      'timestamper'                      => {},
      'token-macro'                      => {},
      'tracking-git'                     => {},
      'tracking-svn'                     => {},
      'translation'                      => {},
      'uptime'                           => {},
      'workflow-api'                     => {},
      'workflow-aggregator'              => {},
      'workflow-basic-steps'             => {},
      'workflow-cps'                     => {},
      'workflow-cps-global-lib'          => {},
      'workflow-durable-task-step'       => {},
      'workflow-job'                     => {},
      'workflow-multibranch'             => {},
      'workflow-scm-step'                => {},
      'workflow-step-api'                => {},
      'workflow-support'                 => {},
      'windows-azure-storage'            => {},
      'windows-exe-runner'               => {},
      'windows-slaves'                   => {},
      'ws-cleanup'                       => {},
      'ws-ws-replacement'                => {},
      'variant'                          => {},
      'vncrecorder'                      => {},
      'vncviewer'                        => {},
    },
  }
#  jenkins_authorization_strategy { 'hudson.security.AuthorizationStrategy$Unsecured':
#    ensure => 'present',
#  }
  include git
  git::config { 'user.name':
#    value => 'hypervci',
    value => 'primeministerp',
  }

  git::config { 'user.email':
#    value => 'hyper-v_ci@microsoft.com',
    value => 'primeministerpete@gmail.com',
  }
  Vcsrepo{
    require => Package['git'],
  }
    file{'/home/jenkins/bin':
      ensure  => directory,
      owner   => 'jenkins',
      group   => 'jenkins',
      mode    => '0770',
      require => User['jenkins'],
    } -> 
    file{'/home/jenkins/bin/github_curl_owner_repo_size.sh':
      ensure  => file,
      owner   => 'jenkins',
      group   => 'jenkins',
      mode    => '0770',
      content => '#!/usr/bin/env bash
if [ "$#" -eq 2 ]; then
    echo "$(echo "scale=2; $(curl https://api.github.com/repos/$1/$2 2>/dev/null \
    | grep size | head -1 | tr -dc '[:digit:]') / 1024" | bc)MB"
elif [ "$#" -eq 3 ] && [ "$1" == "-z" ]; then
    # For some reason Content-Length header is returned only on second try
    curl -I https://codeload.github.com/$2/$3/zip/master &>/dev/null  
    echo "$(echo "scale=2; $(curl -I https://codeload.github.com/$2/$3/zip/master \
    2>/dev/null | grep Content-Length | cut -d' ' -f2 | tr -d '\r') / 1024 / 1024"| bc)MB"
else
    printf "Usage: $(basename $0) [-z] OWNER REPO\n\n"
    printf "Get github repository size or, optionally [-z], the size of the zipped\n"
    printf "master branch (`Download ZIP` link on repo page).\n"
    exit 1
fi
',

    }
}
