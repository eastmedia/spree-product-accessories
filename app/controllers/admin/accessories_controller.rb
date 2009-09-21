class Admin::AccessoriesController < Admin::BaseController
  resource_controller
  belongs_to :product

  before_filter :load_objects

  include ActionView::Helpers::TextHelper

  def add
    @accessories.each do |accessory|
      @product.add_accessory(accessory)
    end
    flash[:notice] = "Successfully added #{@accessories.map(&:name).sort.join(',')} as #{pluralize(@accessories.size, 'accessory')}!"
    @accessories = @product.accessories
    redirect_to admin_product_accessories_url
  end

  def remove
    @product.remove_accessory(@accessory)
    flash[:notice] = "Successfully removed #{@accessory.name} from #{@product.name}'s accessories!"
    @accessories = @product.accessories
    redirect_to admin_product_accessories_url
  end

private
  def load_objects
    @product = Product.find_by_param(params[:product_id]) || Product.find_by_id(params[:product_id])
    if params[:id]
      @accessory = Product.find_by_param(params[:id]) || Product.find_by_id(params[:id])
    end
    if params[:product] && params[:product][:accessory_ids]
      @accessories = Product.find_all_by_id params[:product][:accessory_ids]
    end
  end
end
