module Spree
  class CalculatorCar < BaseCalculator
    # def adults_range
    #   (0..1).to_a
    # end
    #
    # def children_range
    #   (0..1).to_a
    # end

    def calculate_price(context, product, variant, options)
      # TODO hacerlo generico para que se apte cuando hay cambios en los context por el usuario
      return [product.price.to_f] if product.rates.empty?

      # for productos
      # list = Spree::Variant.where(product: product.id).includes(:option_values).where(spree_option_values: {id: context.category(options).to_i}).collect{|v|v.rates}.flatten

      # for variantes
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
            price = days * r.fourteen_tuentynine_days
            array << {price: price, rate: r.id, avg: nil}
          end
        end
      end
      array

    end


    #
    # def get_rate_price(rate, adults, children)
    #   adults = adults.to_i
    #   children = children.to_i
    #   price = adults * rate.one_adult.to_i + children * rate.one_child.to_i
    #   price
    # end

    # private

    # def get_adult_list(rate, pt_adults)
    #   if pt_adults.present?
    #     [pt_adults]
    #   else
    #     adults_range
    #   end
    # end
    #
    # def get_child_list(rate, pt_child)
    #   if pt_child.present?
    #     [pt_child]
    #   else
    #     children_range
    #   end
    # end
  end
end
