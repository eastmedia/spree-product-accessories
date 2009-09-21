class AddAccessoryToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :accessory, :boolean, :default => true, :null => false
  end

  def self.down
    remove_column :products, :accessory
  end
end
