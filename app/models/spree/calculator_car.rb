# frozen_string_literal: true.

module Spree
  class CalculatorCar < BaseCalculator
    def initialize(context:, product:, variant:, options:)
      @product = product
      @variant = variant
      @options = options
      @context_pickup_date = Date.parse(context.pickup_date(options).to_s)
      @context_return_date = Date.parse(context.return_date(options).to_s)
    end

    def calculate_price
      return [price: product.price.to_f] if product.rates.empty?

      rates = variant.rates

      array = []
      rates.each do |rate|
        next unless valid_dates?(rate)

        days = (context_return_date - context_pickup_date).to_i

        price = fetch_price(days, rate)

        array << { price: price.format, rate: rate.id, avg: nil, variant: rate.variant }
      end
      array
    end

    private

    attr_reader :product, :variant, :options, :context_pickup_date, :context_return_date

    def valid_dates?(rate)
      Date.parse(rate.start_date) <= context_pickup_date &&
        Date.parse(rate.end_date) >= context_return_date
    end

    def fetch_price(days, rate)
      rate_per_day = if days >= 3 && days <= 6
                       rate.three_six_days
                     elsif days >= 7 && days <= 13
                       rate.seven_thirteen_days
                     elsif days >= 14 && days <= 29
                       rate.fourteen_twentynine_days
                     end

      days * rate_per_day
    end
  end
end
