# frozen_string_literal: true

module Spree
  module ProductDecorator
    def car?
      product_type == Spree::ProductType.find_by(name: 'car')
    end
  end
end

Spree::Product.prepend Spree::ProductDecorator

module Spree
  module ProductDecoratorClassMethod
    def cars
      joins(:product_type).where('spree_product_types.name = ?', 'car')
    end
  end
end

Spree::Product.singleton_class.send :prepend, Spree::ProductDecoratorClassMethod
