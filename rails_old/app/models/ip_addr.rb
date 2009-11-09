#=============================================================================
#         FILE:  ip_addr.rb
#
#  DESCRIPTION:  Contains the class definition for the 'ip_addrs' table.
#
#         BUGS:  ---
#        NOTES:  ---
#=============================================================================

class IpAddr < ActiveRecord::Base
	belongs_to :mac_addr
	belongs_to :vlan

	validates_presence_of :ip_address
	validate              :ip_well_formed?

	#===========================================================================
	#      METHOD:  ip_well_formed?
	# DESCRIPTION:  Returns true if given a valid IP address
	#
	#        NOTES:  Currently only works with IPv4 addresses; needs to work for
	#                IPv6 addresses also or else just always return true.
	#===========================================================================
	def ip_well_formed?
		unless ip_address && ip_address =~ /^(\d+)\.(\d+)\.(\d+)\.(\d+)$/
			errors.add(:ip_address, "is malformed")
			return false
		end
		
		octets = [$1, $2, $3, $4]

		octets.each { |octet|
			unless octet.to_i <= 256 && octet.to_i >= 0
			 errors.add(:ip_address, "is malformed")
			 return false
			end
		}
		true
	end		

end
