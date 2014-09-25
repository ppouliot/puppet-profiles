require 'facter'
require 'ipaddr'
Facter.add("cidr_netmask") do
  setcode do
   def cidr_to_netmask(cidr) 
     IPAddr.net(:netmask).mask(cidr).to_s
   end
  end
end
