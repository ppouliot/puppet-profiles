# == Class: profiles::jenkins_master
class profiles::jenkins_master(){
  # Jenkins Server Configuration
  class {'jenkins':
    version                              => 'latest',
    lts                                  => false,
    executors                            => 8,
    install_java                         => true,
    configure_firewall                   => true,
    config_hash                          => {
      'HTTP_PORT'                        => {
        'value' => '9000'
       }
    },
    # Jenkins Plugins
    plugin_hash                          => {
      'antisamy-markup-formatter'        => {
        'version' => 'latest'
      },
      'backup'                           => {
        'version' => 'latest'
      },
      'build-view-column'                => {
        'version' => 'latest'
      },
      'built-on-column'                  => {
        'version' => 'latest'
      },
      'credentials'                      => {
        'version' => 'latest'
      },
      'cvs'                              => {
        'version' => 'latest'
      },
      'compact-columns'                  => {
        'version' => 'latest'
      },
      'configure-job-column-plugin'      => {
        'version' => 'latest'i
      },
      'console-column-plugin'            => {
        'version' => 'latest'
      },
      'custom-job-icon'                  => {
        'version' => 'latest'
      },
      'docker-workflow'                  => {
        'version' => 'latest'
      },
      'docker-traceability'              => { 'version' => 'latest' },
      'docker-plugin'                    => { 'version' => 'latest' },
      'docker-custom-build-environment'  => { 'version' => 'latest' },
      'docker-commons'                   => { 'version' => 'latest' },
      'docker-build-step'                => { 'version' => 'latest' },
      'docker-build-publish'             => { 'version' => 'latest' },
      'gerrit'                           => { 'version' => 'latest' },
      'gerrit-trigger'                   => { 'version' => 'latest' },
      'github'                           => { 'version' => 'latest' },
      'github-api'                       => { 'version' => 'latest' },
      'git'                              => { 'version' => 'latest' },
      'git-changelog'                    => { 'version' => 'latest' },
      'git-client'                       => { 'version' => 'latest' },
      'git-chooser-alternative'          => { 'version' => 'latest' },
      'git-notes'                        => { 'version' => 'latest' },
      'git-parameter'                    => { 'version' => 'latest' },
      'git-tag-message'                  => { 'version' => 'latest' },
      'github-branch-source'             => { 'version' => 'latest' },
      'github-pullrequest'               => { 'version' => 'latest' },
      'global-build-stats'               => { 'version' => 'latest' },
      'global-post-script'               => { 'version' => 'latest' },
      'global-variable-string-parameter' => { 'version' => 'latest' },
      'javadoc'                          => { 'version' => 'latest' },
      'junit'                            => { 'version' => 'latest' },
      'job-restrictions'                 => { 'version' => 'latest' },
      'job-parameter-summary'            => { 'version' => 'latest' },
      'jobtemplates'                     => { 'version' => 'latest' },
      'jobtype-column'                   => { 'version' => 'latest' },
      'libvirt-slave'                    => { 'version' => 'latest' },
      'logging'                          => { 'version' => 'latest' },
      'mailer'                           => { 'version' => 'latest' },
      'matrix-auth'                      => { 'version' => 'latest' },
      'matrix-project'                   => { 'version' => 'latest' },
      'maven-plugin'                     => { 'version' => 'latest' },
      'mission-control-view'             => { 'version' => 'latest' },
      'modernstatus'                     => { 'version' => 'latest' },
      'multiple-scms'                    => { 'version' => 'latest' },
      'mysql-job-databases'              => { 'version' => 'latest' },
      'nested-view'                      => { 'version' => 'latest' },
      'network-monitor'                  => { 'version' => 'latest' },
      'openstack-cloud'                  => { 'version' => 'latest' },
      'pam-auth'                         => { 'version' => 'latest' },
      'parallel-test-executor'           => { 'version' => 'latest' },
      'parameterized-trigger'            => { 'version' => 'latest' },
      'powershell'                       => { 'version' => 'latest' },
      'port-allocator'                   => { 'version' => 'latest' },
      'puppet'                           => { 'version' => 'latest' },
      'postbuildscript'                  => { 'version' => 'latest' },
      'prereq-buildstep'                 => { 'version' => 'latest' },
      'project-build-times'              => { 'version' => 'latest' },
      'project-stats-plugin'             => { 'version' => 'latest' },
      'promoted-builds'                  => { 'version' => 'latest' },
      'python'                           => { 'version' => 'latest' },
      'saferestart'                      => { 'version' => 'latest' },
      'saltstack'                        => { 'version' => 'latest' },
      'scp'                              => { 'version' => 'latest' },
      'swarm'                            => { 'version' => 'latest' },
      'subversion'                       => { 'version' => 'latest' },
      'script-security'                  => { 'version' => 'latest' },
      'slave-prerequisites'              => { 'version' => 'latest' },
      'slave-proxy'                      => { 'version' => 'latest' },
      'slave-setup'                      => { 'version' => 'latest' },
      'slave-squatter'                   => { 'version' => 'latest' },
      'slave-status'                     => { 'version' => 'latest' },
      'slave-utilization-plugin'         => { 'version' => 'latest' },
      'stackhammer'                      => { 'version' => 'latest' },
      'started-by-envvar'                => { 'version' => 'latest' },
      'status-view'                      => { 'version' => 'latest' },
      'statusmonitor'                    => { 'version' => 'latest' },
      'systemloadaverage-monitor'        => { 'version' => 'latest' },
      'tfs'                              => { 'version' => 'latest' },
      'thinBackup'                       => { 'version' => 'latest' },
      'timestamper'                      => { 'version' => 'latest' },
      'token-macro'                      => { 'version' => 'latest' },
      'tracking-git'                     => { 'version' => 'latest' },
      'tracking-svn'                     => { 'version' => 'latest' },
      'translation'                      => { 'version' => 'latest' },
      'uptime'                           => { 'version' => 'latest' },
      'windows-azure-storage'            => { 'version' => 'latest' },
      'windows-exe-runner'               => { 'version' => 'latest' },
      'windows-slaves'                   => { 'version' => 'latest' },
      'vncrecorder'                      => { 'version' => 'latest' },
      'vncviewer'                        => { 'version' => 'latest' },
    },
  }

  file{'/root/bin/jenkins_master-export_jobs.sh':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0777',
    content => tempate('profiles/jenkins_master-export_jobs.sh.erb'),
  }
}
