require File.dirname(__FILE__) + '/../../spec_helper'

describe Admin::AccessoriesController do
  before do
    activate_authlogic
    @admin = create_admin
    UserSession.create(@admin)

    @product    = Factory(:product)
    @accessory  = Factory(:product)
    @accessory2 = Factory(:product)
  end

  it "#adds an accessory to the product" do
    put :add, :product_id => @product.id, :product => { :accessory_ids => [@accessory.id] }
    @product.accessories.should include(@accessory)
    flash[:notice].should =~ /successfully added/i
  end
  it "#adds multiple accessories to the product" do
    put :add, :product_id => @product.id, :product => { :accessory_ids => [@accessory.id, @accessory2.id] }
    @product.accessories.should include(@accessory)
    @product.accessories.should include(@accessory2)
    flash[:notice].should =~ /successfully added/i
  end
  it "#removes an accessory from the product" do
    delete :remove, :product_id => @product.id, :id => @accessory.id
    @product.accessories.should_not include(@accessory)
    flash[:notice].should =~ /successfully removed/i
  end

  def create_admin
    u = Factory(:user)
    u.roles << Factory(:role, :name => 'user')
    u.roles << Factory(:role, :name => 'admin')
    u
  end
end
