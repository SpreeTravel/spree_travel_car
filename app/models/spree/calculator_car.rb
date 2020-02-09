module Spree
  class CalculatorCar < BaseCalculator

    def calculate_price(context, product, variant, options)
      return [price:product.price.to_f] if product.rates.empty?

      list = variant.rates

      array = []
      list.each do |r|
        if Date.parse(r.start_date) <= Date.parse(context.pickup_date(options).to_s) &&
            Date.parse(r.end_date) >= Date.parse(context.return_date(options).to_s)

          days = (Date.parse(context.return_date(options).to_s) - Date.parse(context.pickup_date(options).to_s)).to_i

          if days >= 3 and days <= 6
            price = days * r.three_six_days
            array << {price: price, rate: r.id, avg: nil}
          elsif days >= 7 and days <= 13
            price = days * r.seven_thirteen_days
            array << {price: price, rate: r.id, avg: nil}
          elsif  days >= 14 and days <=29
            price = days * r.fourteen_twentynine_days
            array << {price: price, rate: r.id, avg: nil}
          end
        end
      end
      array

    end

  end
end
