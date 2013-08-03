module Spree
  Product.class_eval do

    def car?
      false
    end

    def rentacar?
      false
    end
  end
end
