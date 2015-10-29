module Spree
  Product.class_eval do

    def car?
      self.product_type == Spree::ProductType.find_by_name('car')
    end
  end
end
