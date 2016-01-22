module Spree
  Product.class_eval do

    def car?
      self.product_type == Spree::ProductType.find_by_name('car')
    end
    
    def self.cars
      where(product_type_id: Spree::ProductType.find_by_name('car').id )
    end
    
  end
end
