require_dependency 'application'

class ProductAccessoriesExtension < Spree::Extension
  version "1.0"
  description "Adds accessories to products using a self-referential habtm association"
  url "http://github.com/eastmedia/spree-accessories"

  def self.require_gems(config)
    config.gem "thoughtbot-factory_girl", :lib => "factory_girl", :source => "http://gems.github.com"
    config.gem "faker"
  end

  def activate
    Product.class_eval do
      has_and_belongs_to_many :accessories, :class_name => 'Product', :join_table => 'accessories_products', :foreign_key => 'product_id', :association_foreign_key => 'accessory_id'

      def add_accessory(accessory)
        unless accessories.include? accessory
          accessories << accessory
          accessory.update_attribute :accessory, true
        end
      end

      def remove_accessory(accessory)
        if accessories.include? accessory
          accessories.delete accessory
          accessory.update_attribute :accessory, false
        end
      end
    end

  end

  Admin::BaseController.class_eval do
    before_filter :add_accessories_tab

    private
    def add_accessories_tab
      @product_admin_tabs << {:name => t('accessories'), :url => "admin_product_accessories_url"}
    end 
  end 
end
