# == Class: profiles::kvm_host
class profiles::kvm_host(){
  warning("${fqdn} is a puppet managed kvm virtualization host configured by the profiles::docker_host class")
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
    'virt-manager']:
    ensure => 'latest'
  }
}
