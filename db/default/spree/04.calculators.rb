### Creating calculator if not created before
product_type = Spree::ProductType.find_by_name('car')
Spree::TravelCalculator.where(name: 'Spree::CalculatorCar').first_or_create(product_type: product_type)
