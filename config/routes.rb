# Put your extension routes here.

map.namespace :admin do |admin|
   admin.resources :products do |product|
     product.resources :accessories, :member => {:remove => :delete}, :collection => {:add => :post}
   end
end
