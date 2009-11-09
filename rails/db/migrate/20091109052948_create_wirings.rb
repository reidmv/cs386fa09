class CreateWirings < ActiveRecord::Migration
  def self.up
    create_table :wirings do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :wirings
  end
end
