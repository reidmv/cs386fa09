class CreateIpAddrs < ActiveRecord::Migration
  def self.up
    create_table :ip_addrs do |t|
      t.address :ip_addr

      t.timestamps
    end
  end

  def self.down
    drop_table :ip_addrs
  end
end
