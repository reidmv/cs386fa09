#=============================================================================
#         FILE:  wiring.rb
#
#  DESCRIPTION:  Contains the class definition for the 'wirings' table.
#
#         BUGS:  ---
#        NOTES:  ---
#=============================================================================
class Wiring < ActiveRecord::Base
	belongs_to :host

end
