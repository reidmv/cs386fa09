class CreatePorts < ActiveRecord::Migration
  def self.up
    create_table :ports do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :ports
  end
end
