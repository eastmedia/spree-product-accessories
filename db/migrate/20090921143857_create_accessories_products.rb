class CreateAccessoriesProducts < ActiveRecord::Migration
  def self.up
    create_table "accessories_products", :force => true, :id => false do |t|
      t.integer :product_id
      t.integer :accessory_id
    end
  end

  def self.down
    drop_table "accessories_products"
  end
end
