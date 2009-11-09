class CreateIpAddrs < ActiveRecord::Migration
  def self.up
    create_table :ip_addrs do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :ip_addrs
  end
end
