Spree Product Accessories
=========================

Spree Product Accessories is an extension for the Spree E-Commerce Platform (http://spreecommerce.com/) that allows you to associate products with accessories. In this extension, accessories are just products that have been associated with other products. 

This extension uses a self-referential has_and_belongs_to_many association to relate products with accessories. It also sets a boolean flag on products called 'accessory' to facilitate filtering out products that are accessories.

Usage
=====

@product.add_accessory(@other_product)
@other_product.accessory? # => true

>> @product = Product.first
  Product Load (0.4ms)   SELECT * FROM `products` LIMIT 1
=> #<Product id: 25673712, name: "Ruby on Rails Ringer T-Shirt", description: "Lorem ipsum dolor sit amet, consectetuer adipiscing...", master_price: #<BigDecimal:31b7cd8,'0.1799E2',8(8)>, created_at: "2009-09-17 21:49:46", updated_at: "2009-09-21 17:47:48", permalink: "ruby-on-rails-ringer-t-shirt", available_on: "2009-09-17 21:49:46", tax_category_id: nil, shipping_category_id: nil, deleted_at: nil, meta_description: nil, meta_keywords: nil, accessory: false>

>> @other_product = Product.first(:order => 'rand()')
  Product Load (1.7ms)   SELECT * FROM `products` ORDER BY rand() LIMIT 1
=> #<Product id: 768308771, name: "Ruby on Rails Bag", description: "Lorem ipsum dolor sit amet, consectetuer adipiscing...", master_price: #<BigDecimal:31acd38,'0.2299E2',8(8)>, created_at: "2009-09-17 21:49:46", updated_at: "2009-09-21 17:56:01", permalink: "ruby-on-rails-bag", available_on: "2009-09-17 21:49:46", tax_category_id: nil, shipping_category_id: nil, deleted_at: nil, meta_description: nil, meta_keywords: nil, accessory: false>


>> @product.add_accessory(@other_product)
  Product Exists (0.4ms)   SELECT `products`.id FROM `products` INNER JOIN `accessories_products` ON `products`.id = `accessories_products`.accessory_id WHERE (`products`.`id` = 768308771) AND (`accessories_products`.product_id = 25673712 ) LIMIT 1
  SQL (0.1ms)   BEGIN
  accessories_products Columns (1.2ms)   SHOW FIELDS FROM `accessories_products`
SQL (0.7ms)   INSERT INTO `accessories_products` (`product_id`, `accessory_id`) VALUES (25673712, 768308771)
  SQL (0.4ms)   COMMIT
  SQL (0.1ms)   BEGIN
  SQL (0.4ms)   SELECT count(*) AS count_all FROM `products` WHERE (products.permalink = 'ruby-on-rails-bag' and products.id != 768308771)
  Product Update (0.3ms)   UPDATE `products` SET `accessory` = 1, `updated_at` = '2009-09-21 18:10:42' WHERE `id` = 768308771
  SQL (0.8ms)   COMMIT
=> true

>> @product.accessories
  Product Load (0.5ms)   SELECT * FROM `products` INNER JOIN `accessories_products` ON `products`.id = `accessories_products`.accessory_id WHERE (`accessories_products`.product_id = 25673712 )
=> [#<Product id: 768308771, name: "Ruby on Rails Bag", description: "Lorem ipsum dolor sit amet, consectetuer adipiscing...", master_price: #<BigDecimal:3189658,'0.2299E2',8(8)>, created_at: "2009-09-17 21:49:46", updated_at: "2009-09-21 18:10:42", permalink: "ruby-on-rails-bag", available_on: "2009-09-17 21:49:46", tax_category_id: nil, shipping_category_id: nil, deleted_at: nil, meta_description: nil, meta_keywords: nil, accessory: true>]

>> @other_product.accessory?
=> true

>> @product.remove_accessory(@other_product)
  SQL (0.1ms)   BEGIN
  SQL (0.2ms)   DELETE FROM `accessories_products` WHERE product_id = 25673712 AND accessory_id IN (768308771)
  SQL (0.6ms)   COMMIT
  SQL (0.1ms)   BEGIN
  SQL (0.4ms)   SELECT count(*) AS count_all FROM `products` WHERE (products.permalink = 'ruby-on-rails-bag' and products.id != 768308771)
  Product Update (0.2ms)   UPDATE `products` SET `accessory` = 0, `updated_at` = '2009-09-21 18:11:46' WHERE `id` = 768308771
  SQL (0.4ms)   COMMIT
=> true

>> @product.accessories
=> []

>> @other_product.accessory?
=> false

