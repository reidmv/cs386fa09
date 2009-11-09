class Vlan < ActiveRecord::Base
#	set_primary_key :vlan_id
	has_many :ip_addrs
end
