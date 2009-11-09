class CreateVirtualPorts < ActiveRecord::Migration
  def self.up
    create_table :virtual_ports do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :virtual_ports
  end
end
