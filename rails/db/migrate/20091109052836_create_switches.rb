class CreateSwitches < ActiveRecord::Migration
  def self.up
    create_table :switches do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :switches
  end
end
