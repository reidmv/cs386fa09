class MacAddr < ActiveRecord::Base
	belongs_to :port,
      		   :foreign_key => 'port_id'
	has_many   :ip_addrs,
		         :dependent   => :destroy
end
