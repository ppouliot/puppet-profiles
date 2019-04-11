class profiles::jenkins_master (
) {

  include git
  git::config { 'user.name':
    value => 'primeministerp',
  }

  git::config { 'user.email':
    value => 'primeministerpete@gmail.com',
  }
  Vcsrepo{
    require => Package['git'],
  }

  # Use Vagrant from mainstream and not from pkg mgmt.
#  staging::deploy{'vagrant_2.2.2_linux_amd64.zip':
#    source => 'https://releases.hashicorp.com/vagrant/2.2.2/vagrant_2.2.2_linux_amd64.zip',
#    target => '/usr/local/bin',
#    creates => '/usr/local/bin/vagrant'
#  }

# Use the Unoffical Vagrant Debian Repository
# https://vagrant-deb.linestarve.com/
  apt::source{'wolfgang42-vagrant':
    comment  => 'The Unoffical Vagrant Debian Repository',
    location => 'https://vagrant-deb.linestarve.com',
    release  => 'any',
    repos    => 'main',
    key      => { 
      id => 'AD319E0F7CFFA38B4D9F6E55CE3F3DE92099F7A4',
      server => 'keyserver.ubuntu.com',
    }
  }
  # Use the Offical Oracle Virtualbox Repos
  apt::source{'oracle-virtualbox':
    comment  => 'The Offical Virtualbox Debian Repository',
    location => 'https://download.virtualbox.org/virtualbox/debian',
    release  => 'bionic',
    repos    => 'contrib',
    key      => {
      id => 'B9F8D658297AF3EFC18D5CDFA2F683C52980AECF',
      server => 'keyserver.ubuntu.com',
    }
  }
  class {'docker':
    tcp_bind                    => 'tcp://0.0.0.0:4243',
    socket_bind                 => 'unix:///var/run/docker.sock',
    version                     => latest,
    use_upstream_package_source => true,
  }
  include ::profiles::beaker
  include ::profiles::golang
  include ::profiles::puppet_gems
  package{[
    # Light UI for Mgmt
    'blackbox','tightvncserver','xterm','virt-manager',
    # httpasswd file management tools
    'apache2-utils','expect',
    # Puppet Development kit
    'pdk','ruby-bundler',
    # Virtualbox/Vagrant
    'vagrant','virtualbox','jq','schroot','mercurial','bc',
    # Hardware Control Tools
    'ipmitool','freeipmi','openipmi',
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
    'PyGithub',
    # redfish client
    'python-redfish',
    'sushy',
    'docker-compose',
  ]:
    ensure   => 'latest',
    provider => 'pip',
  }

  # Gem Tools
  package{'octokit':
    ensure   => latest,
    provider => gem,
  }

  Jenkins::Plugin{ version => 'latest', }
  class { 'java' :
    package => 'openjdk-8-jdk', 
  }
->class {'jenkins':
    version                              => 'latest',
    lts                                  => false,
    executors                            => 8,
    install_java                         => false,
    configure_firewall                   => true,
    config_hash                          => {
      'HTTP_PORT'                        => {'value' => '9000' }
    },
    user_hash => {
       'jenkins' => {
         'password' => 'jenkins',
         'email'    => 'jenkins@${fqdn}',
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
      'azure-publishersettings-credentials' => {},
      'azure-batch-parallel'                => {},
      'blueocean-executor-info'             => {},
      'blueocean'                           => {},
      'blueocean-autofavorite'              => {},
      'blueocean-bitbucket-pipeline'        => {},
      'blueocean-commons'                   => {},
      'blueocean-config'                    => {},
      'blueocean-core-js'                   => {},
      'blueocean-dashboard'                 => {},
      'blueocean-display-url'               => {},
      'jenkins-design-language'             => {},
      'blueocean-events'                    => {},
      'blueocean-git-pipeline'              => {},
      'blueocean-github-pipeline'           => {},
      'blueocean-i18n'                      => {},
      'blueocean-jira'                      => {},
      'blueocean-jwt'                       => {},
      'blueocean-pipeline-api-impl'         => {},
      'blueocean-pipeline-scm-api'          => {},
      'blueocean-pipeline-editor'           => {},
      'blueocean-personalization'           => {},
      'blueocean-rest'                      => {},
      'blueocean-rest-impl'                 => {},
      'blueocean-web'                       => {},
      'backup'                              => {},
      'branch-api'                          => {},
      'bouncycastle-api'                    => {},
      'build-alias-setter'                  => {},
      'build-blocker-plugin'                => {},
      'build-cause-run-condition'           => {},
      'build-env-propagator'                => {},
      'build-environment'                   => {},
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
      'built-on-column'                     => {},
      'cvs'                                 => {},
      'cloud-stats'                         => {},
      'cloudbees-folder'                    => {},
      'cloudbees-bitbucket-branch-source'   => {},
      'copyartifact'                        => {},
      'copy-data-to-workspace-plugin'       => {},
      'compact-columns'                     => {},
      'command-launcher'                    => {},
      'config-file-provider'                => {},
      'configure-job-column-plugin'         => {},
      'console-column-plugin'               => {},
      'custom-job-icon'                     => {},
      'conditional-buildstep'               => {},
      'credentials-binding'                 => {},
      'dashboard-view'                      => {},
      'database-mysql'                      => {},
      'database'                            => {},
      'deployment-notification'             => {},
      'display-url-api'                     => {},
      'docker-workflow'                     => {},
      'docker-traceability'                 => {},
      'docker-plugin'                       => {},
      'docker-custom-build-environment'     => {},
      'docker-commons'                      => {},
      'docker-build-step'                   => {},
      'docker-build-publish'                => {},
      'docker-java-api'                     => {},
      'dockerhub-notification'              => {},
      'durable-task'                        => {},
      'email-ext'                           => {},
      'ez-templates'                        => {},
      'email-ext'                           => {},
      'favorite'                            => {},
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
      'google-git-notes-publisher'          => {},
      'handlebars'                          => {},
      'handy-uri-templates-2-api'           => {},
      'htmlpublisher'                       => {},
      'hudson-wsclean-plugin'               => {},
      'icon-shim'                           => {},
      'jackson2-api'                        => {},
      'javadoc'                             => {},
      'jdk-tool'                            => {},
      'jira'                                => {},
      'jsch'                                => {},
      'junit'                               => {},
      'jquery'                              => {},
      'jquery-detached'                     => {},
      'job-dsl'                             => {},
      'job-restrictions'                    => {},
      'job-parameter-summary'               => {},
      'jobtemplates'                        => {},
      'jobtype-column'                      => {},
      'ldap'                                => {},
      'libvirt-slave'                       => {},
      'logging'                             => {},
      'lockable-resources'                  => {},
      'mailer'                              => {},
      'mapdb-api'                           => {},
      'matrix-auth'                         => {},
      'matrix-project'                      => {},
      'maven-plugin'                        => {},
      'mercurial'                           => {},
      'mission-control-view'                => {},
      'modernstatus'                        => {},
      'momentjs'                            => {},
      'mysql-job-databases'                 => {},
      'nested-view'                         => {},
      'network-monitor'                     => {},
      'openstack-cloud'                     => {},
      'pam-auth'                            => {},
      'plain-credentials'                   => {},
      'parallel-test-executor'              => {},
      'parameterized-trigger'               => {},
      'pipeline-aggregator-view'            => {},
      'pipeline-build-step'                 => {},
      'pipeline-graph-analysis'             => {},
      'pipeline-github-lib'                 => {},
      'pipeline-githubnotify-step'          => {},
      'pipeline-input-step'                 => {},
      'pipeline-maven'                      => {},
      'pipeline-milestone-step'             => {},
      'pipeline-model-api'                  => {},
      'pipeline-model-declarative-agent'    => {},
      'pipeline-model-definition'           => {},
      'pipeline-model-extensions'           => {},
      'pipeline-multibranch-defaults'       => {},
      'pipeline-npm'                        => {},
      'pipeline-rest-api'                   => {},
      'pipeline-stage-step'                 => {},
      'pipeline-stage-tags-metadata'        => {},
      'pipeline-stage-view'                 => {},
      'pipeline-utility-steps'              => {},
      'powershell'                          => {},
      'port-allocator'                      => {},
      'puppet'                              => {},
      'prereq-buildstep'                    => {},
      'project-build-times'                 => {},
      'project-stats-plugin'                => {},
      'promoted-builds'                     => {},
      'pubsub-light'                        => {},
      'python'                              => {},
      'run-condition'                       => {},
      'ruby'                                => {},
      'ruby-runtime'                        => {},
      'resource-disposer'                   => {},
      'saferestart'                         => {},
      'saltstack'                           => {},
      'semantic-versioning-plugin'          => {'enabled' => false},
      'ssh-slaves'                          => {},
      'shared-workspace'                    => {},
      'ssh-agent'                           => {},
      'ssh-credentials'                     => {},
      'scm-api'                             => {},
      'sidebar-link'                        => {},
      'swarm'                               => {},
      'subversion'                          => {},
      'script-security'                     => {},
      'slave-prerequisites'                 => {},
      'slave-proxy'                         => {},
      'slave-setup'                         => {},
      'slave-squatter'                      => {},
      'slave-status'                        => {},
      'slave-utilization-plugin'            => {},
      'sse-gateway'                         => {},
      'stackhammer'                         => {},
      'started-by-envvar'                   => {},
      'status-view'                         => {},
      'statusmonitor'                       => {},
      'systemloadaverage-monitor'           => {},
      'tasks'                               => {},
      'tfs'                                 => {},
      'thinBackup'                          => {},
      'timestamper'                         => {},
      'token-macro'                         => {},
      'tracking-git'                        => {},
      'tracking-svn'                        => {},
      'translation'                         => {},
      'trilead-api'                         => {},
      'uptime'                              => {},
      'workflow-api'                        => {},
#      'workflow-aggregator '               => {},
      'workflow-basic-steps'                => {},
      'workflow-cps'                        => {},
      'workflow-cps-global-lib'             => {},
      'workflow-durable-task-step'          => {},
      'workflow-job'                        => {},
      'workflow-multibranch'                => {},
      'workflow-scm-step'                   => {},
      'workflow-step-api'                   => {},
      'workflow-support'                    => {},
#     'windows-azure-storage'               => {},
      'windows-exe-runner'                  => {},
      'windows-slaves'                      => {},
      'ws-cleanup'                          => {},
      'ws-ws-replacement'                   => {},
      'variant'                             => {},
      'virtualbox'                          => {},
      'vboxwrapper'                         => {},
      'vncrecorder'                         => {},
      'vncviewer'                           => {},
    },
  }
#  jenkins_authorization_strategy { 'hudson.security.AuthorizationStrategy$Unsecured':
#    ensure => 'present',
#  }
->file{'/var/lib/jenkins/bin':
    ensure  => directory,
    owner   => 'jenkins',
    group   => 'jenkins',
    mode    => '0770',
    require => User['jenkins'],
  }
->file{'/var/lib/jenkins/bin/jenkins-cli.jar':
    ensure => file,
    source => '/var/cache/jenkins/war/WEB-INF/jenkins-cli.jar',
    mode   => '0777',
    owner  => 'root',
    group  => 'root',
  }
->file{'/var/lib/jenkins/bin/github_curl_owner_repo_size.sh':
    ensure => file,
    owner  => 'jenkins',
    group  => 'jenkins',
    mode   => '0770',
    source => 'puppet:///modules/profiles/github_curl_owner_repo_size.sh',
  }
->file{'/var/lib/jenkins/userContent':
    ensure => directory,
    owner  => 'jenkins',
    group  => 'jenkins',
    mode   => '0755',
  }
->archive{'/var/lib/jenkins/userContent/puppet.svg':
    ensure => present,
    source => 'https://www.nutanix.com/wp-content/uploads/2017/02/logo_puppet.svg',
    user   => 'jenkins',
    group  => 'jenkins',
  }
->archive{'/var/lib/jenkins/userContent/ansible.svg':
    ensure => present,
    source => 'https://www.elao.com/images/logo_ansible.svg',
    user   => 'jenkins',
    group  => 'jenkins',
  }
->archive{'/var/lib/jenkins/userContent/ansible_awx.svg':
    ensure => present,
    source => 'https://raw.githubusercontent.com/ansible/awx-logos/master/awx/ui/client/assets/logo-login.svg',
    user   => 'jenkins',
    group  => 'jenkins',
  }
->archive{'/var/lib/jenkins/userContent/chef.svg':
    ensure => present,
    source => 'https://upload.wikimedia.org/wikipedia/commons/8/8a/Chef_logo.svg',
    user   => 'jenkins',
    group  => 'jenkins',
  }
}
