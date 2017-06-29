class profiles::jenkins_master () {
#  class{'profiles::shipyard':}
  package{[
    # Light UI for Mgmt
    'blackbox','tightvncserver','xterm','virt-manager',
    # httpasswd file management tools
    'apache2-utils',
    # Beaker Requrements
    'make','ruby-dev','libxml2-dev','libxslt1-dev','g++','zlib1g-dev',
    # Puppet Lint Syntax testing
    'puppet-lint',
  ]:
    ensure          => 'latest'
  } ->
  class{'nodejs':}
  package{'azure-cli':
    ensure   => 'latest',
    provider => 'npm',
  }



  class{'python':
#    pip     => 'present',
  } ->
  package{[
    # JJB
    'jenkins-job-builder',
    # JJW
    'jenkins-job-wrecker',
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

  # Puppetlabs Beaker Acceptance Testing Tool
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
    plugin_hash                          => {
      'ace-editor'                          => { version => 'latest' },
      'analysis-core'                       => { version => 'latest' },
      'ant'                                 => { version => 'latest' },
      'antisamy-markup-formatter'           => { version => 'latest' },
      'authentication-tokens'               => { version => 'latest' },
      'ansicolor'                           => { version => 'latest' },
      'azure-vm-agents'                     => { version => 'latest' },
      'azure-slave-plugin'                  => { version => 'latest' },
      'azure-credentials'                   => { version => 'latest' },
      'azure-publishersettings-credentials' => { version => 'latest' },
      'windows-azure-storage'               => { version => 'latest' },
      'azure-batch-parallel'                => { version => 'latest' },
      'backup'                              => { version => 'latest' },
      'branch-api'                          => { version => 'latest' },
      'bouncycastle-api'                    => { version => 'latest' },
      'build-alias-setter'                  => { version => 'latest' },
      'build-blocker-plugin'                => { version => 'latest' },
      'build-cause-run-condition'           => { version => 'latest' },
      'build-env-propagator'                => { version => 'latest' },
      'build-environment'                   => { version => 'latest' },
#      'build-failure-analyzer'              => { version => 'latest' },
      # Build flow is depreciated  for pipeline
#      'build-flow-extensions-plugin'        => { 'enabled' => false },
#      'build-flow-plugin'                   => { 'enabled' => false },
#      'build-flow-test-aggregator'          => { 'enabled' => false },
#      'build-flow-toolbox-plugin'           => { 'enabled' => false },
      # 
      'build-history-metrics-plugin'        => { version => 'latest' },
      'build-keeper-plugin'                 => { version => 'latest' },
      'build-line'                          => { version => 'latest' },
      'build-metrics'                       => { version => 'latest' },
      'build-monitor-plugin'                => { version => 'latest' },
      'build-name-setter'                   => { version => 'latest' },
      'build-pipeline-plugin'               => { version => 'latest' },
      'build-requester'                     => { version => 'latest' },
      'build-timeout'                       => { version => 'latest' },
      'build-timestamp'                     => { version => 'latest' },
      'build-view-column'                   => { version => 'latest' },
#      'buildgraph-view'                     => { version => 'latest' },
      'built-on-column'                     => { version => 'latest' },
      'cvs'                                 => { version => 'latest' },
      'cloud-stats'                         => { version => 'latest' },
      'cloudbees-folder'                    => { version => 'latest' },
      'copyartifact'                        => { version => 'latest' },
      'copy-data-to-workspace-plugin'       => { version => 'latest' },
      'compact-columns'                     => { version => 'latest' },
      'config-file-provider'                => { version => 'latest' },
      'configure-job-column-plugin'         => { version => 'latest' },
      'console-column-plugin'               => { version => 'latest' },
      'custom-job-icon'                     => { version => 'latest' },
      'conditional-buildstep'               => { version => 'latest' },
#     Credentials is already defined in base module
#     'credentials'                         => { version => 'latest' },
      'credentials-binding'                 => { version => 'latest' },
      'dashboard-view'                      => { version => 'latest' },
      'deployment-notification'             => { version => 'latest' },
      'display-url-api'                     => { version => 'latest' },
      'docker-workflow'                     => { version => 'latest' },
      'docker-slaves'                       => { version => 'latest' },
      'docker-traceability'                 => { version => 'latest' },
      'docker-plugin'                       => { version => 'latest' },
      'docker-custom-build-environment'     => { version => 'latest' },
      'docker-commons'                      => { version => 'latest' },
      'docker-build-step'                   => { version => 'latest' },
      'docker-build-publish'                => { version => 'latest' },
      'durable-task'                        => { version => 'latest' },
      'envinject'                           => { version => 'latest' },
      'envinject-api'                       => { version => 'latest' },
      'ez-templates'                        => { version => 'latest' },
      'gerrit'                              => { version => 'latest' },
      'gerrit-trigger'                      => { version => 'latest' },
      'github'                              => { version => 'latest' },
      'github-api'                          => { version => 'latest' },
      'git'                                 => { version => 'latest' },
      'git-changelog'                       => { version => 'latest' },
      'git-client'                          => { version => 'latest' },
      'git-server'                          => { version => 'latest' },
      'git-chooser-alternative'             => { version => 'latest' },
      'git-notes'                           => { version => 'latest' },
      'git-parameter'                       => { version => 'latest' },
      'git-tag-message'                     => { version => 'latest' },
      'git-userContent'                     => { version => 'latest' },
      'github'                              => { version => 'latest' },
      'github-api'                          => { version => 'latest' },
      'github-branch-source'                => { version => 'latest' },
      'github-issues'                       => { version => 'latest' },
      'github-pullrequest'                  => { version => 'latest' },
      'github-pr-comment-build'             => { version => 'latest' },
      'github-pr-coverage-status'           => { version => 'latest' },
      'global-build-stats'                  => { version => 'latest' },
      'global-post-script'                  => { version => 'latest' },
      'global-variable-string-parameter'    => { version => 'latest' },
      'groovy'                              => { version => 'latest' },
      'groovy-events-listener-plugin'       => { version => 'latest' },
      'groovy-events-listener-plugin-master' => { version => 'latest' },
      'groovy-label-assignment'             => { version => 'latest' },
      'groovy-postbuild'                 => { version => 'latest' },
      'groovy-remote'                    => { version => 'latest' },
#      'groovyaxis'                       => { 'enabled' => false },
      'handlebars'                       => { version => 'latest' },
      'hudson-wsclean-plugin'            => { version => 'latest' },
      'icon-shim'                        => { version => 'latest' },
      'jackson2-api'                        => { version => 'latest' },
      'jenkins-multijob-plugin'          => { version => 'latest' },
      'javadoc'                          => { version => 'latest' },
      'junit'                            => { version => 'latest' },
      'jquery'                           => { version => 'latest' },
      'jquery-detached'                  => { version => 'latest' },
      'job-restrictions'                 => { version => 'latest' },
      'job-parameter-summary'            => { version => 'latest' },
      'jobtemplates'                     => { version => 'latest' },
      'jobtype-column'                   => { version => 'latest' },
      'ldap'                             => { version => 'latest' },
      'libvirt-slave'                    => { version => 'latest' },
      'logging'                          => { version => 'latest' },
      'mailer'                           => { version => 'latest' },
      'mapdb-api'                        => { version => 'latest' },
      'matrix-auth'                      => { version => 'latest' },
      'matrix-project'                   => { version => 'latest' },
      'maven-plugin'                     => { version => 'latest' },
      'mission-control-view'             => { version => 'latest' },
      'modernstatus'                     => { version => 'latest' },
      'momentjs'                         => { version => 'latest' },
      'multiple-scms'                    => { version => 'latest' },
      'mysql-job-databases'              => { version => 'latest' },
      'nested-view'                      => { version => 'latest' },
      'network-monitor'                  => { version => 'latest' },
      'openstack-cloud'                  => { version => 'latest' },
#      'openstack-heat'                   => { version => 'latest' },
      'pam-auth'                         => { version => 'latest' },
      'plain-credentials'                => { version => 'latest' },
      'parallel-test-executor'           => { version => 'latest' },
      'parameterized-trigger'            => { version => 'latest' },
      'pipeline-aggregator-view'         => { version => 'latest' },
      'pipeline-build-step'              => { version => 'latest' },
      'pipeline-graph-analysis'          => { version => 'latest' },
      'pipeline-github-lib'              => { version => 'latest' },
      'pipeline-githubnotify-step'       => { version => 'latest' },
      'pipeline-input-step'              => { version => 'latest' },
      'pipeline-maven'                   => { version => 'latest' },
      'pipeline-milestone-step'          => { version => 'latest' },
      'pipeline-model-api'               => { version => 'latest' },
      'pipeline-model-declarative-agent' => { version => 'latest' },
      'pipeline-model-definition'        => { version => 'latest' },
      'pipeline-model-extensions'        => { version => 'latest' },
      'pipeline-multibranch-defaults'    => { version => 'latest' },
      'pipeline-npm'                     => { version => 'latest' },
      'pipeline-rest-api'                => { version => 'latest' },
      'pipeline-stage-step'              => { version => 'latest' },
      'pipeline-stage-tags-metadata'     => { version => 'latest' },
      'pipeline-stage-view'              => { version => 'latest' },
      'pipeline-utility-steps'           => { version => 'latest' },
      'powershell'                       => { version => 'latest' },
      'port-allocator'                   => { version => 'latest' },
      'puppet'                           => { version => 'latest' },
#      'postbuildscript'                  => { 'enabled' => false },
      'prereq-buildstep'                 => { version => 'latest' },
      'project-build-times'              => { version => 'latest' },
      'project-stats-plugin'             => { version => 'latest' },
      'promoted-builds'                  => { version => 'latest' },
      'python'                           => { version => 'latest' },
      'run-condition'                    => { version => 'latest' },
      'ruby-runtime'                     => { version => 'latest' },
      'resource-disposer'                => { version => 'latest' },
      'saferestart'                      => { version => 'latest' },
      'saltstack'                        => { version => 'latest' },
      'ssh-slaves'                       => { version => 'latest' },
      'shared-workspace'                 => { version => 'latest' },
      'ssh-credentials'                  => { version => 'latest' },
      'scp'                              => { version => 'latest' },
      'scm-api'                          => { version => 'latest' },
      'sidebar-link'                     => { version => 'latest' },
      'swarm'                            => { version => 'latest' },
      'subversion'                       => { version => 'latest' },
      'script-security'                  => { version => 'latest' },
      'slave-prerequisites'              => { version => 'latest' },
      'slave-proxy'                      => { version => 'latest' },
      'slave-setup'                      => { version => 'latest' },
      'slave-squatter'                   => { version => 'latest' },
      'slave-status'                     => { version => 'latest' },
      'slave-utilization-plugin'         => { version => 'latest' },
      'structs'                          => { version => 'latest' },
      'stackhammer'                      => { version => 'latest' },
      'started-by-envvar'                => { version => 'latest' },
      'status-view'                      => { version => 'latest' },
      'statusmonitor'                    => { version => 'latest' },
      'systemloadaverage-monitor'        => { version => 'latest' },
      'tasks'                            => { version => 'latest' },
      'tfs'                              => { version => 'latest' },
      'thinBackup'                       => { version => 'latest' },
      'timestamper'                      => { version => 'latest' },
      'token-macro'                      => { version => 'latest' },
      'tracking-git'                     => { version => 'latest' },
      'tracking-svn'                     => { version => 'latest' },
      'translation'                      => { version => 'latest' },
      'uptime'                           => { version => 'latest' },
      'workflow-api'                     => { version => 'latest' },
      'workflow-aggregator'              => { version => 'latest' },
      'workflow-basic-steps'             => { version => 'latest' },
      'workflow-cps'                     => { version => 'latest' },
      'workflow-cps-global-lib'          => { version => 'latest' },
      'workflow-durable-task-step'       => { version => 'latest' },
      'workflow-job'                     => { version => 'latest' },
      'workflow-multibranch'             => { version => 'latest' },
      'workflow-scm-step'                => { version => 'latest' },
      'workflow-step-api'                => { version => 'latest' },
      'workflow-support'                 => { version => 'latest' },
      'windows-azure-storage'            => { version => 'latest' },
      'windows-exe-runner'               => { version => 'latest' },
      'windows-slaves'                   => { version => 'latest' },
      'ws-cleanup'                       => { version => 'latest' },
      'ws-ws-replacement'                => { version => 'latest' },
      'vncrecorder'                      => { version => 'latest' },
      'vncviewer'                        => { version => 'latest' },
    },
  }

  git::config { 'user.name':
#    value => 'hypervci',
    value => 'primeministerp',
  }

  git::config { 'user.email':
#    value => 'hyper-v_ci@microsoft.com',
    value => 'primeministerpete@gmail.com',
  }
}
