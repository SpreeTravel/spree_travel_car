# frozen_string_literal: true

module Spree
  module RateDecorator
    def self.prepended(base)
      base.validate :check_dates, :check_dates_overlap
    end

    %i[
      start_date end_date three_six_days seven_thirteen_days fourteen_twentynine_days
    ].each do |method|
      define_method method do
        get_persisted_option_value(method)
      end
    end

    def check_dates
      start_date, end_date = find_dates

      errors.add :end_date, 'must be after start date' if end_date <= start_date
    end

    def check_dates_overlap
      rates = Rate.where(variant_id: variant_id)

      start_date, end_date = find_dates

      rates.each do |rate|
        overlap = rate.end_date.to_date >= start_date && end_date >= rate.start_date.to_date
        break errors.add :overlaps, 'there is another rate with those days' if overlap
      end
    end

    def find_dates
      start_date = Spree::OptionValue.find_by_name('start_date')
      end_date = Spree::OptionValue.find_by_name('end_date')

      start_date = rate_option_values.select {|e| e.option_value_id == start_date.id }.first.value
      end_date = rate_option_values.select {|e| e.option_value_id == end_date.id }.first.value

      [start_date.to_date, end_date.to_date]
    end
  end
end

Spree::Rate.prepend Spree::RateDecorator
