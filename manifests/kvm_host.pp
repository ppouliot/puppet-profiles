# == Class: profiles::kvm_host
class profiles::kvm_host(){
  warning("${::fqdn} is a puppet managed kvm virtualization host configured by the profiles::docker_host class")
  # KVM/Libvirt/QEMU
  class { 'libvirt':
    qemu_vnc_listen => '0.0.0.0',
    qemu_vnc_sasl   => false,
    qemu_vnc_tls    => false,
  } ->
  # Remote Management GUI & Virtualization Mgmt Tools
  package{[
    'blackbox',
    'tightvncserver',
    'xterm',
    'virt-manager',
    'ssh-askpass'
  ]:
    ensure => 'latest'
  }
  # sysctl.conf
  # net.bridge.bridge-nf-call-ip6tables = 0
  # net.bridge.bridge-nf-call-iptables = 0
  # net.bridge.bridge-nf-call-arptables = 0
  # This is needed to allow for PXEbooting when running DHCP or ProxyDHCP on the KVM host
  sysctl{ 'net.bridge.bridge-nf-call-ip6tables':
    ensure => 'present',
    value  => '0',
    comment => 'Disable IPv6 UDP filter on Bridge interfaces to allow PXE from guests when running DHCPD/DHCPPROXY on KVM Host',
  }
  sysctl{ 'net.bridge.bridge-nf-call-iptables':
    ensure => 'present',
    value  => '0',
    comment => 'Disable IPv4 UDP filter on Bridge interfaces to allow PXE from guests when running DHCPD/DHCPPROXY on KVM Host',
  }
  sysctl{ 'net.bridge.bridge-nf-call-arptables':
    ensure => 'present',
    value  => '0',
    comment => 'Disable ARP UDP filter on Bridge interfaces to allow PXE from guests when running DHCPD/DHCPPROXY on KVM Host',
  }
}
