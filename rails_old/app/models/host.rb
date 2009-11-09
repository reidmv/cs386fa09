#=============================================================================
#         FILE:  host.rb
#
#  DESCRIPTION:  Contains the class definition for the 'hosts' table.
#
#         BUGS:  ---
#        NOTES:  ---
#=============================================================================
class Host < ActiveRecord::Base
	has_many :ports,
		       :dependent   => :destroy,
		       :foreign_key => 'host_id'
	has_many :mac_addrs,
		       :through => :ports

	validates_uniqueness_of :hostname
	validates_presence_of   :hostname, :building, :room, :owner

	#===========================================================================
	#      METHOD: first_ip
	# DESCRIPTION: Returns the first IP address associated with the host.
	#===========================================================================
	def first_ip
		if (self.ports.first && 
				self.ports.first.mac_addrs.first && 
				self.ports.first.mac_addrs.first.ip_addrs.first)
			self.ports.first.mac_addrs.first.ip_addrs.first.ip_address
		else
			nil
		end
	end

	#===========================================================================
	#      METHOD: interface
	# DESCRIPTION: Returns the specified interface (port), or with no interface
	#              specification returns the first interface.
	#===========================================================================
	def interface(name = nil)
		if name
		  self.ports.first(:conditions => {:label => name})
		else
		  self.ports.first
		end
	end

end
