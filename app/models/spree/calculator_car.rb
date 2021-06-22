# frozen_string_literal: true

module Spree
  class CalculatorCar < BaseCalculator
    def initialize(context:, variant:, options:)
      @variant = variant
      @options = options
      @context_pickup_date = Date.parse(context.pickup_date(options).to_s)
      @context_return_date = Date.parse(context.return_date(options).to_s)
    end

    def calculate_price
      days = (context_return_date - context_pickup_date).to_i

      variant.context_price = fetch_price(days, rate)
      variant.rate_price = rate.id
    end

    private

    def rate
      @start_date ||= Spree::OptionValue.select(:id).find_by(name: 'start_date')
      @end_date ||= Spree::OptionValue.select(:id).find_by(name: 'end_date')

      @rate ||= Spree::FindRates.new(variant_id: variant.id,
                                     start_date_option_value_id: @start_date.id,
                                     end_date_option_value_id: @end_date.id,
                                     context_pickup_date: context_pickup_date,
                                     context_return_date: context_return_date).execute
    end

    attr_reader :product, :variant, :options, :context_pickup_date, :context_return_date

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
