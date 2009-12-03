#=============================================================================
#         FILE:  mac_addr.rb
#
#  DESCRIPTION:  Contains the class definition for the 'mac_addrs' table.
#
#         BUGS:  ---
#        NOTES:  ---
#=============================================================================
class MacAddr < ActiveRecord::Base

	before_validation :validate_mac

	belongs_to :port,
               :foreign_key => 'port_id'
	has_many   :ip_addrs,
	           :dependent   => :destroy

	validates_uniqueness_of :mac_address
	validates_presence_of   :mac_address

	#===========================================================================
	#      METHOD: validate_mac
	# DESCRIPTION: Validates the format of a mac address. Necessary because ruby
	#              seems to run the validate_uniqueness check first, which when
	#              combined with a malformed mac address causes an error to be
	#              given by postgresql. This is performed before_validation.
	#===========================================================================
	def validate_mac
		unless mac_address =~ /\A([\da-fA-F]{2}:){5}[\da-fA-F]{2}\Z/
			errors.add(:mac_address, "invalid format")
			return false
		end
	end
end
