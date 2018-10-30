# Private Internet Access VPN Assumes 
wget https://www.privateinternetaccess.com/openvpn/openvpn-strong-tcp.zip
unzip openvpn-strong-tcp.zip

set interfaces openvpn vtun0 config-file /config/auth/us-florida.ovpn
set interfaces openvpn vtun0 description 'Private Internet Access VPN'
