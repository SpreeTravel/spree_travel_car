# frozen_string_literal: true

module Spree
  module ProductDecorator
    def car?
      product_type == Spree::ProductType.find_by_name('car')
    end
  end
end

Spree::Product.prepend Spree::ProductDecorator

module Spree
  module ProductDecoratorClassMethod
    def cars
      where(product_type_id: Spree::ProductType.find_by_name('car').id)
    end
  end
end

Spree::Product.singleton_class.send :prepend, Spree::ProductDecoratorClassMethod
