module Spree::ProductDecorator
  def car?
    self.product_type == Spree::ProductType.find_by_name('car')
  end
end

Spree::Product.prepend Spree::ProductDecorator

module Spree::ProductDecoratorClassMethod
  def cars
    where(product_type_id: Spree::ProductType.find_by_name('car').id )
  end
end

Spree::Product.singleton_class.send :prepend, Spree::ProductDecoratorClassMethod
