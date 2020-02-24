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

          price = if days >= 3 and days <= 6
                    days * r.three_six_days
                  elsif days >= 7 and days <= 13
                    days * r.seven_thirteen_days
                  elsif  days >= 14 and days <=29
                    days * r.fourteen_twentynine_days
                  end

          array << {price: price.format, rate: r.id, avg: nil}

        end
      end
      array

    end

  end
end
