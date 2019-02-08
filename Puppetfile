forge "http://forge.puppet.com"

# Modules from the Puppet Forge
# Versions should be updated to be the latest at the time you start
#mod "puppetlabs/inifile",     '1.5.0'
#mod "puppetlabs/stdlib",      '4.11.0'
#mod "puppetlabs/concat",      '2.1.0'

# Modules from Git
# Examples: https://github.com/puppetlabs/r10k/blob/master/doc/puppetfile.mkd#examples
#mod 'apache',
#  :git    => 'https://github.com/puppetlabs/puppetlabs-apache',
#  :commit => '83401079053dca11d61945bd9beef9ecf7576cbf'

#mod 'apache',
#  :git    => 'https://github.com/puppetlabs/puppetlabs-apache',
#  :branch => 'docs_experiment'


# Pulling Modules Directly without Versions in an attempt to get the latest
# Current Version of AJJAHN DNS from forge.puppet.com only works with stdlib 4.10.0 Switching to Git Master Below

# archlinux/alpinelinux
mod "aboe/pacman", :latest
# Network Device
mod "aristanetworks/eos", :latest
mod "aristanetworks/netdev_stdlib_eos", :latest

# MAC
mod "bjoernalbers/mysql_osx", :latest
# Depreciating module ->
# mod "gildas/homebrew", :latest
mod "thekevjames/homebrew", :latest
mod "grahamgilbert/macdefaults", :latest
mod "grahamgilbert/mac_facts", :latest
mod "grahamgilbert/mac_admin", :latest
mod "jethrocarr/timemachine", :latest
mod "glarizza/osx_management", :latest
mod "glarizza/property_list_key", :latest
mod "jaredjennings/mac_plist_value", :latest
mod "rcoleman/mac_profiles_handler", :latest
mod "sfu/managedmac", :latest
mod "skoblenick-vagrant", :latest
mod "skoblenick-skype", :latest
mod "skoblenick-sourcetree", :latest
# mod "skoblenick-jenkins", :latest
mod "skoblenick-firefox", :latest
mod "skoblenick-appcleaner", :latest
# mod "skoblenick-java", :latest
# mod "skoblenick-nodejs", :latest
mod "skoblenick-vmware_fusion", :latest
mod "skoblenick-unarchiver", :latest
mod "skoblenick-pycharm", :latest
mod "skoblenick-chrome", :latest
# mod "skoblenick-virtualbox", :latest
mod "skoblenick-vlc", :latest
mod "skoblenick-xquartz", :latest
mod "skoblenick-wireshark", :latest
mod "skoblenick-filezilla", :latest
# mod "skoblenick-git", :latest
mod "skoblenick-blender", :latest
mod "skoblenick-sophos", :latest
mod "skoblenick-asepsis", :latest


# Begin Linux/Win
mod "aboe/chrony", :latest
mod "albatrossflavour/os_patching", :latest
mod "ajcrowe/confd", :latest
# mod "ajjahn/dns", :latest
#  commit adds newer concat
mod "ajjahn/dns", # Using master for dns to support puppet-ipam
   :git => 'https://github.com/ppouliot/puppet-dns',
#   :commit => '4cb6dfe377e2ea48498e181b630f4215f1117a2e'
   :branch => 'master'
mod "ajjahn/samba", :latest
mod "arioch/redis", :latest
# mod "badgerious/windows_env", :latest
mod "basti1302/windows_path", :latest
#mod "croddy/make", :latest
mod "chocolatey/chocolatey", :latest
mod "chocolatey/chocolatey_server", :latest
mod "cristifalcas/etcd", :latest
mod "cristifalcas/flannel", :latest
mod "cristifalcas/kubernetes", :latest
# mod "darin/zypprepo", :latest
mod "dalen/puppetdbquery", :latest
# mod "dhollinger/autofs", :latest
mod "derdanne/nfs", :latest
mod "garethr/erlang", :latest
# mod "garethr/docker", :latest
# This module requires a cluster api
#mod "garethr/kubernetes", :latest
mod "gentoo/portage", :latest
mod "ghoneycutt/ssh", :latest
mod "herculesteam/augeasproviders", :latest
mod "herculesteam/augeasproviders_apache", :latest
mod "herculesteam/augeasproviders_base", :latest
mod "herculesteam/augeasproviders_core", :latest
mod "herculesteam/augeasproviders_grub", :latest
mod "herculesteam/augeasproviders_mounttab", :latest
mod "herculesteam/augeasproviders_nagios", :latest
mod "herculesteam/augeasproviders_pam", :latest
mod "herculesteam/augeasproviders_postgresql", :latest
mod "herculesteam/augeasproviders_puppet", :latest
mod "herculesteam/augeasproviders_ssh", :latest
mod "herculesteam/augeasproviders_shellvar", :latest
mod "herculesteam/augeasproviders_sysctl", :latest
mod "herculesteam/augeasproviders_syslog", :latest
mod "jamtur01/httpauth", :latest
mod "jhoblitt/ganglia", :latest
mod "jsok/vault", :latest
mod "ktreese/nssm", :latest
mod "KyleAnderson/consul", :latest
# mod "luxflux/openvpn", :latest
# Currently adding support for proxydhcp in downstream
mod "saz/dnsmasq", :latest
mod "lboynton/rpmforge", :latest
mod "liamjbennett/win_facts", :latest
mod "lwf/remote_file", :latest
#mod "maestrodev/ssh_keygen", :latest
#mod "michaeltchapman/galera", :latest
# michaelchapemen is depreciated
mod "fraenki/galera", :latest
mod "mosen/cups", :latest
mod "noma4i/windows_xmltask", :latest
mod "opendaylight/opendaylight", :latest
mod "otherskins/ansible", :latest
# VoxPupuli Modules
mod "puppet/amanda", :latest
# autofs pinning to 4.3.0 for quartermaster module
mod "puppet/autofs", '4.3.0' #:latest
mod "puppet/archive", :latest
mod "puppet/unattended_upgrades", :latest
mod "puppet/cron", :latest
mod "puppet/corosync", :latest
mod "puppet/community_kickstarts", :latest
mod "puppet/dhcp", :latest
mod "puppet/drbd", :latest
mod "puppet/download_file", :latest
mod "puppet/dotnet", :latest
mod "puppet/etherpad", :latest
mod "puppet/gerrit", :latest
mod "puppet/graphite_powershell", :latest
mod "puppet/healthcheck", :latest
mod "puppet/jenkins_job_builder", :latest
mod "puppet/letsencrypt", :latest
mod "puppet/logrotate", :latest
mod "puppet/make", :latest
mod "puppet/mrepo", :latest
mod "puppet/msoffice", :latest
mod "puppet/nginx", :latest
mod "puppet/nodejs", :latest
mod "puppet/openvpn", :latest
mod "puppet/puppetboard", :latest
mod "puppet/ssh_keygen", :latest
mod "puppet/r10k", :latest
mod "puppet/rabbitmq", :latest
mod "puppet/wget", :latest
# 
#mod "puppet/rhsm", # :latest
#  :git => 'https://github.com/voxpupuli/puppet-rhsm',
#  :branch => 'master'
  
# puppet-puppetserver on github.com/voxpupuli/puppet-puppetserver
mod "camptocamp/augeas", :latest
mod "camptocamp/dell", :latest
mod "camptocamp/kmod", :latest
#mod "camptocamp/puppetserver", :latest
mod "puppet/selinux", :latest
mod "puppet/squid", :latest
mod "puppet/sslcertificate", :latest
mod "puppet/staging", :latest
mod "puppet/smokeping", :latest
mod "puppet/virtualbox", :latest
mod "puppet/windows_autoupdate", :latest
mod "puppet/windows_env", :latest
mod "puppet/windows_eventlog", :latest
mod "puppet/windows_firewall", :latest
mod "puppet/windows_power", :latest
mod "puppet/windowsfeature", :latest
mod "puppet/yum", :latest
mod "puppet/zabbix", :latest
mod "puppet/zypprepo", :latest
# PuppetLabs Modules
mod "puppetlabs/acl", :latest
mod "puppetlabs/accounts", :latest
mod "puppetlabs/apache", :latest
mod "puppetlabs/apt", :latest
# Pinning to 3.x for Now due to 4.x breaking things in postgresql
#  :git => 'https://github.com/puppetlabs/puppetlabs-apt',
#  :branch => 'master'
#  :tag => '3.0.0' 
mod "puppetlabs/augeas_core", :latest
mod "puppetlabs/cron_core", :latest
mod "puppetlabs/host_core", :latest
mod "puppetlabs/mount_core", :latest
mod "puppetlabs/selinux_core", :latest
mod "puppetlabs/sshkeys_core", :latest
#mod "puppetlabs/yumrepo_core", :latest
mod "puppetlabs/zfs_core", :latest
mod "puppetlabs/zone_core", :latest
mod "puppetlabs/aws", :latest
mod "puppetlabs/azure", :latest
mod "puppetlabs/catalog_preview", :latest
mod "puppetlabs/cisco_ios", :latest
mod "puppetlabs/ciscopuppet", :latest
mod "puppetlabs/concat", :latest
mod "puppetlabs/device_manager", :latest
mod "puppetlabs/dsc", :latest
mod "puppetlabs/dsc_lite", :latest
mod "puppetlabs/dism", :latest
mod "puppetlabs/docker", :latest
mod "puppetlabs/dummy_service", :latest
mod "puppetlabs/firewall", :latest
mod "puppetlabs/gcc", :latest
mod "puppetlabs/git", :latest
mod "puppetlabs/haproxy", :latest
mod "puppetlabs/hocon", :latest
mod "puppetlabs/iis", :latest
mod "puppetlabs/inifile", :latest
mod "puppetlabs/image_build", :latest
mod "puppetlabs/inventory", :latest
mod "puppetlabs/java", :latest
mod "puppetlabs/java_ks", :latest
mod "puppetlabs/lvm", :latest
mod "puppetlabs/motd", :latest
mod "puppetlabs/mount_iso", :latest
mod "puppetlabs/mysql", :latest
mod "puppetlabs/ntp", :latest
mod "puppetlabs/netdev_stdlib", :latest
mod "puppetlabs/pe_gem", :latest
mod "puppetlabs/postgresql", :latest
#  :git => 'https://github.com/puppetlabs/puppetlabs-postgresql',
#  :branch => 'master'
mod "puppetlabs/powershell", :latest
mod "puppetlabs/puppet_conf", :latest
mod "puppetlabs/puppet_agent", :latest
mod "puppetlabs/puppet_authorization", :latest
mod "puppetlabs/puppetdb", :latest
mod "puppetlabs/puppetserver_gem", :latest
mod "puppetlabs/registry", :latest
mod "puppetlabs/reboot", :latest
mod "puppetlabs/rkt", :latest
mod "puppetlabs/rsync", :latest
mod "puppetlabs/ruby", :latest
mod "puppetlabs/stdlib", :latest
mod "puppetlabs/tagmail", :latest
# Switching from forge.puppet.com version 0.2.3 to Master branch which 
# accounts for systemd/upstart change in ubuntu and fixes:
# Error: /Stage[main]/Tftp/Service[tftpd-hpa]: Provider upstart is not functional on this host
mod "puppetlabs/tftp",  #:latest
  :git    => 'https://github.com/puppetlabs/puppetlabs-tftp',
  :branch => 'master'
mod "puppetlabs/tomcat", :latest
mod "puppetlabs/transition", :latest
mod "puppetlabs/translate", :latest
mod "puppetlabs/vcsrepo", :latest
mod "puppetlabs/win_desktop_shortcut", :latest
mod "puppetlabs/wsus_client", :latest
mod "puppetlabs/xinetd", :latest
mod "razorsedge/vmwaretools",  :latest
# need to use master until 1.8.0 is release due to problem w/ jenkins/manifests/repo/debian.pp
# Location of Jenkins module changed to the voxpupuli repos
mod "rtyler/jenkins", # :latest
  :git    => 'https://github.com/voxpupuli/puppet-jenkins',
  :branch => 'master'

mod "rcoleman/netatalk", :latest
mod "saz/memcached", :latest
mod "saz/rsyslog", :latest
mod "saz/timezone", :latest
mod "sensu/sensu", :latest
mod "ssm/munin", :latest
mod "stm/debconf", :latest
mod "spotify/puppetexplorer", :latest
mod "stahnma/epel", :latest
mod "stankevich/python", :latest
#mod "theforman/dns", :latest
mod "thias/libvirt", :latest
mod "thias/quagga", :latest
mod "thias/sysctl", :latest
mod "vshn/gitlab", :latest

# GitHub Only
# Moving Quartermaster Module dnsmaq config to this add a template for proxydhcp to send upstream
#mod "lex/dnsmasq",
#  :git    => 'https://github.com/ppouliot/puppet-dnsmasq',
#  :branch => 'master'
mod "puppet/puppetserver", 
  :git    => 'https://github.com/voxpupuli/puppet-puppetserver',
  :branch => 'master'

# PPouliot Modules not upstream
mod "puppet/juju", 
  :git    => 'https://github.com/ppouliot/puppet-juju',
  :branch => 'master'
mod "puppet/maas", 
  :git    => 'https://github.com/ppouliot/puppet-maas',
  :branch => 'master'
mod "puppet/profiles", 
  :git    => 'https://github.com/ppouliot/puppet-profiles',
  :branch => 'master'
mod "puppet/quartermaster", 
  :git    => 'https://github.com/ppouliot/puppet-quartermaster',
  :branch => 'master'
mod "puppet/ipam", 
  :git    => 'https://github.com/ppouliot/puppet-ipam',
  :branch => 'master'
mod "puppet/hyper_v", 
  :git    => 'https://github.com/ppouliot/puppet-hyper_v',
  :branch => 'master'
mod "puppet/dell_openmanage", 
  :git    => 'https://github.com/ppouliot/puppet-dell_openmanage',
  :branch => 'master'
mod "puppet/petools", 
  :git    => 'https://github.com/ppouliot/puppet-petools',
  :branch => 'master'
mod "puppet/windows_autologon",
  :git    => 'https://github.com/ppouliot/puppet-windows_autologon',
  :branch => 'master'
mod "puppet/windows_containers",
  :git    => 'https://github.com/ppouliot/puppet-windows_containers',
  :branch => 'master'
mod "puppet/windows_iscsi",
  :git    => 'https://github.com/ppouliot/puppet-windows_iscsi',
  :branch => 'master'
mod "puppet/windows_platform_facts",
  :git    => 'https://github.com/ppouliot/puppet-windows_platform_facts',
  :branch => 'master'
mod "puppet/windows_shortcut",
  :git    => 'https://github.com/ppouliot/puppet-windows_shortcut',
  :branch => 'master'
mod "puppet/windows_service",
  :git    => 'https://github.com/ppouliot/puppet-windows_service',
  :branch => 'master'
mod "puppet/windows_terminal_services",
  :git    => 'https://github.com/ppouliot/puppet-windows_terminal_services',
  :branch => 'master'
mod "puppet/windows_time",
  :git    => 'https://github.com/ppouliot/puppet-windows_time',
  :branch => 'master'

# OpenStack Puppet Modules

mod  "openstack/aodh",
  :git    => 'https://github.com/openstack/puppet-aodh',
  :branch => 'stable/rocky'

mod  "openstack/autossh",
  :git    => 'https://github.com/openstack/puppet-autossh',
  :branch => 'master'

mod  "openstack/barbican",
  :git    => 'https://github.com/openstack/puppet-barbican',
  :branch => 'stable/rocky'

mod  "openstack/ceilometer",
  :git    => 'https://github.com/openstack/puppet-ceilometer',
  :branch => 'stable/rocky'

mod  "openstack/ceph",
  :git    => 'https://github.com/openstack/puppet-ceph',
  :branch => 'master'

mod  "openstack/cinder",
  :git    => 'https://github.com/openstack/puppet-cinder',
  :branch => 'stable/rocky'

mod  "openstack/cloudkitty",
  :git    => 'https://github.com/openstack/puppet-cloudkitty',
  :branch => 'master'

mod  "openstack/congress",
  :git    => 'https://github.com/openstack/puppet-congress',
  :branch => 'stable/rocky'

mod  "openstack/designate",
  :git    => 'https://github.com/openstack/puppet-designate',
  :branch => 'stable/rocky'

mod  "openstack/ec2api",
  :git    => 'https://github.com/openstack/puppet-ec2api',
  :branch => 'stable/rocky'

mod  "openstack/freezer",
  :git    => 'https://github.com/openstack/puppet-freezer',
  :branch => 'master'

mod  "openstack/glance",
  :git    => 'https://github.com/openstack/puppet-glance',
  :branch => 'stable/rocky'

mod  "openstack/glare",
  :git    => 'https://github.com/openstack/puppet-glare',
  :branch => 'master'

mod  "openstack/gnocchi",
  :git    => 'https://github.com/openstack/puppet-gnocchi',
  :branch => 'stable/rocky'

mod  "openstack/heat",
  :git    => 'https://github.com/openstack/puppet-heat',
  :branch => 'stable/rocky'

mod  "openstack/horizon",
  :git    => 'https://github.com/openstack/puppet-horizon',
  :branch => 'stable/rocky'

mod  "openstack/ironic",
  :git    => 'https://github.com/openstack/puppet-ironic',
  :branch => 'stable/rocky'

mod  "openstack/keystone",
  :git    => 'https://github.com/openstack/puppet-keystone',
  :branch => 'stable/rocky'

mod  "openstack/magnum",
  :git    => 'https://github.com/openstack/puppet-magnum',
  :branch => 'stable/rocky'

mod  "openstack/manila",
  :git    => 'https://github.com/openstack/puppet-manila',
  :branch => 'stable/rocky'

mod  "openstack/midonet",
  :git    => 'https://github.com/openstack/puppet-midonet',
  :branch => 'master'

mod  "openstack/mistral",
  :git    => 'https://github.com/openstack/puppet-mistral',
  :branch => 'stable/rocky'

mod  "openstack/monasca",
  :git    => 'https://github.com/openstack/puppet-monasca',
  :branch => 'master'

mod  "openstack/murano",
  :git    => 'https://github.com/openstack/puppet-murano',
  :branch => 'stable/rocky'

mod  "openstack/neutron",
  :git    => 'https://github.com/openstack/puppet-neutron',
  :branch => 'stable/rocky'

mod  "openstack/nova",
  :git    => 'https://github.com/openstack/puppet-nova',
  :branch => 'stable/rocky'

mod  "openstack/octavia",
  :git    => 'https://github.com/openstack/puppet-octavia',
  :branch => 'stable/rocky'

mod  "openstack/openstack_extras",
  :git    => 'https://github.com/openstack/puppet-openstack_extras',
  :branch => 'stable/rocky'

mod  "openstack/openstack_spec_helper",
  :git    => 'https://github.com/openstack/puppet-openstack_spec_helper',
  :branch => 'stable/rocky'

mod  "openstack/openstacklib",
  :git    => 'https://github.com/openstack/puppet-openstacklib',
  :branch => 'stable/rocky'

mod  "openstack/oslo",
  :git    => 'https://github.com/openstack/puppet-oslo',
  :branch => 'stable/rocky'

mod  "openstack/ovn",
  :git    => 'https://github.com/openstack/puppet-ovn',
  :branch => 'stable/rocky'

mod  "openstack/pacemaker",
  :git    => 'https://github.com/openstack/puppet-pacemaker',
  :branch => 'master'

mod  "openstack/panko",
  :git    => 'https://github.com/openstack/puppet-panko',
  :branch => 'stable/rocky'

mod  "openstack/qdr",
  :git    => 'https://github.com/openstack/puppet-qdr',
  :branch => 'master'

mod  "openstack/rally",
  :git    => 'https://github.com/openstack/puppet-rally',
  :branch => 'master'

mod  "openstack/sahara",
  :git    => 'https://github.com/openstack/puppet-sahara',
  :branch => 'stable/rocky'

mod  "openstack/setproxy",
  :git    => 'https://github.com/openstack/puppet-setproxy',
  :branch => 'master'

mod  "openstack/swift",
  :git    => 'https://github.com/openstack/puppet-swift',
  :branch => 'stable/rocky'

mod  "openstack/tacker",
  :git    => 'https://github.com/openstack/puppet-tacker',
  :branch => 'stable/rocky'

mod  "openstack/tempest",
  :git    => 'https://github.com/openstack/puppet-tempest',
  :branch => 'stable/rocky'

mod  "openstack/tripleo",
  :git    => 'https://github.com/openstack/puppet-tripleo',
  :branch => 'stable/rocky'

mod  "openstack/trove",
  :git    => 'https://github.com/openstack/puppet-trove',
  :branch => 'stable/rocky'

mod  "openstack/vitrage",
  :git    => 'https://github.com/openstack/puppet-vitrage',
  :branch => 'master'

mod  "openstack/vswitch",
  :git    => 'https://github.com/openstack/puppet-vswitch',
  :branch => 'stable/rocky'

mod  "openstack/watcher",
  :git    => 'https://github.com/openstack/puppet-watcher',
  :branch => 'stable/rocky'

mod  "openstack/zaqar",
  :git    => 'https://github.com/openstack/puppet-zaqar',
  :branch => 'stable/rocky'
# Custom Fact
mod  "ppouliot/rakuten_datacenters",
  :git    => 'git@github.rakops.com:raklab/puppet-rakuten_datacenters.git',
  :branch => 'master'

mod 'puppet/vyos',
    :git => 'https://github.com/ppouliot/vyos-builder',
    :branch => 'puppet'

mod 'ppouliot/fetchfact',
    :git => 'https://github.com/ppouliot/puppet-fetchfact',
    :branch => 'master'
mod 'ppouliot/location',
    :git => 'https://github.com/ppouliot/puppet-location',
    :branch => 'master'
mod 'GeoffWilliams/lastrun_face',
    :git => 'https://github.com/GeoffWilliams/lastrun_face',
    :branch => 'master'
mod 'declarativesystems/r_profile',
    :git => 'https://github.com/declarativesystems/r_profile',
    :branch => 'master'
