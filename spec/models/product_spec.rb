require 'spec_helper'

describe Spree::Product, type: :model do
  describe 'car?' do
    let(:car_product_type) { build_stubbed(:product_type, name: 'car', presentation: 'Car') }
    let(:renault) { build_stubbed(:travel_product, product_type: car_product_type) }

    it 'is a car?' do
      expect(Spree::ProductType).to receive(:find_by).with(name: 'car').and_return(car_product_type)

      renault.car?
    end
  end

  it 'cars' do
    expect(Spree::Product).to receive(:joins).with(:product_type).and_return(Spree::Product)
    expect(Spree::Product).to receive(:where).with('spree_product_types.name = ?', 'car')

    Spree::Product.cars
  end


end