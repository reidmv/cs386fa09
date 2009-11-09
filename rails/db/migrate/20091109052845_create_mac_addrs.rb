class CreateMacAddrs < ActiveRecord::Migration
  def self.up
    create_table :mac_addrs do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :mac_addrs
  end
end
