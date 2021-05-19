# frozen_string_literal: true.

module Spree
  class CalculatorCar < BaseCalculator
    def initialize(context:, variant:, options:)
      @variant = variant
      @options = options
      @context_pickup_date = Date.parse(context.pickup_date(options).to_s)
      @context_return_date = Date.parse(context.return_date(options).to_s)
    end

    def calculate_price
      return [price: variant.product.price.to_f] if variant.rates.empty?

      start_date = Spree::OptionValue.select(:id).find_by(name: 'start_date')
      end_date = Spree::OptionValue.select(:id).find_by(name: 'end_date')

      rate = fetch_query(start_date, end_date)

      days = (context_return_date - context_pickup_date).to_i

      variant.context_price = fetch_price(days, rate)
      variant.rate_price = rate.id
    end

    private

    attr_reader :product, :variant, :options, :context_pickup_date, :context_return_date

    def fetch_query(start_date, end_date)
      joins_clause = "INNER JOIN spree_rate_option_values as rot1 ON rot1.rate_id = spree_rates.id AND rot1.option_value_id = #{start_date.id}" \
                      "INNER JOIN spree_rate_option_values as rot2 ON rot2.rate_id = spree_rates.id AND rot2.option_value_id = #{end_date.id}"
      where_clause = "spree_rates.variant_id = ? and rot1.date_value <= ? and rot2.date_value >= ?"

      Spree::Rate.joins(joins_clause)
                 .where(where_clause, variant.id, context_pickup_date, context_return_date).take
    end

    def fetch_price(days, rate)
      rate_per_day = if days >= 3 && days <= 6
                       rate.three_six_days
                     elsif days >= 7 && days <= 13
                       rate.seven_thirteen_days
                     elsif days >= 14 && days <= 29
                       rate.fourteen_twentynine_days
                     else
                       Spree::Money.new(0).money
                     end

      days * rate_per_day
    end
  end
end
