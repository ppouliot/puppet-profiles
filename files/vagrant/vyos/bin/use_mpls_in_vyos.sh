#
# https://gist.github.com/higebu/415e5862659ff5620e0b
# http://www.samrussell.nz/2015/12/mpls-testbed-on-ubuntu-linux-with.html
# https://qiita.com/kwi/items/bccf38b69e089b729da9

modprobe mpls_router
modprobe mpls_iptunnel
modprobe mpls_gso
sysctl -w net.mpls.platform_labels=1000

ip link add veth0 type veth peer name veth1
ip link add veth2 type veth peer name veth3
sysctl -w net.mpls.conf.veth0.input=1
sysctl -w net.mpls.conf.veth2.input=1
ifconfig veth0 10.3.3.1/24 up
ifconfig veth2 10.4.4.1/24 up
ip netns add host1
ip netns add host2
ip link set veth1 netns host1
ip link set veth3 netns host2
ip netns exec host1 ifconfig lo 10.10.10.1/32 up
ip netns exec host1 ifconfig veth1 10.3.3.2/24 up
ip netns exec host2 ifconfig lo 10.10.10.2/32 up
ip netns exec host2 ifconfig veth3 10.4.4.2/24 up
ip netns exec host1 ip route add 10.10.10.2/32 encap mpls 112 via inet 10.3.3.1
ip netns exec host2 ip route add 10.10.10.1/32 encap mpls 111 via inet 10.4.4.1
ip -f mpls route add 111 via inet 10.3.3.2
ip -f mpls route add 112 via inet 10.4.4.2

# Testing
ip netns exec host2 ping 10.10.10.1 -I 10.10.10.2
tcpdump -envi veth0
