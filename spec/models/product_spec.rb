require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Product do
  describe "accessories" do
    before do
      @product = Factory(:product)
      @accessory = Factory(:product)
    end

    it "sets the accessory product's accessory flag to true after adding" do
      lambda { @product.add_accessory(@accessory) }.should change(@accessory, :accessory).from(false).to(true)
    end

    it "adds an accessory once" do
      @product.add_accessory(@accessory)
      @product.accessories.should include(@accessory)

      lambda { @product.add_accessory(@accessory) }.should_not change(@product.accessories, :size)
    end

    it "sets the accessory product's accessory flag to false after removing" do
      @product.add_accessory(@accessory)
      lambda { @product.remove_accessory(@accessory) }.should change(@accessory, :accessory).from(true).to(false)
    end
  end
end
