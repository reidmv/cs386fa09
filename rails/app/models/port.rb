#=============================================================================
#         FILE:  port.rb
#
#  DESCRIPTION:  Contains the class definition for the 'ports' table.
#
#         BUGS:  ---
#        NOTES:  ---
#=============================================================================
class Port < ActiveRecord::Base
	belongs_to :host
	has_many   :mac_addrs,
	           :dependent => :destroy
	has_one    :connection,
	           :dependent => :destroy
end
