module Spree
  class CalculatorCar < BaseCalculator

    def calculate_price(context, product, variant, options)
      return [price:product.price.to_f] if product.rates.empty?

      rates = variant.rates

      array = []
      rates.each do |rate|
        if Date.parse(rate.start_date) <= Date.parse(context.pickup_date(options).to_s) &&
            Date.parse(rate.end_date) >= Date.parse(context.return_date(options).to_s)

          days = (Date.parse(context.return_date(options).to_s) - Date.parse(context.pickup_date(options).to_s)).to_i

          price = if days >= 3 and days <= 6
                    days * rate.three_six_days
                  elsif days >= 7 and days <= 13
                    days * rate.seven_thirteen_days
                  elsif  days >= 14 and days <=29
                    days * rate.fourteen_twentynine_days
                  end

          array << {price: price.format, rate: rate.id, avg: nil, variant: rate.variant}

        end
      end
      array

    end

  end
end
