# frozen_string_literal: true

module Spree
  class FindRates
    def initialize(variant_id:, start_date_option_value_id:, end_date_option_value_id:,
                   context_pickup_date:, context_return_date:)
      @variant_id = variant_id
      @start_date_option_value_id = start_date_option_value_id
      @end_date_option_value_id = end_date_option_value_id
      @context_pickup_date = context_pickup_date
      @context_return_date = context_return_date
    end

    def execute
      joins_clause = %{INNER JOIN spree_rate_option_values as rot1
                         ON rot1.rate_id = spree_rates.id AND rot1.option_value_id = #{start_date_option_value_id}
                       INNER JOIN spree_values as start_date
                         ON start_date.valuable_id = rot1.id AND start_date.valuable_type = 'Spree::RateOptionValue'
                       INNER JOIN spree_rate_option_values as rot2
                         ON rot2.rate_id = spree_rates.id AND rot2.option_value_id = #{end_date_option_value_id}
                       INNER JOIN spree_values as end_date
                         ON end_date.valuable_id = rot2.id AND end_date.valuable_type = 'Spree::RateOptionValue'}

      where_clause = "spree_rates.variant_id = ? and start_date.date <= ? and end_date.date >= ?"

      Spree::Rate.joins(joins_clause)
                 .where(where_clause, variant_id, context_pickup_date, context_return_date).take
    end

    private

    attr_reader :variant_id, :start_date_option_value_id, :end_date_option_value_id,
                :context_pickup_date, :context_return_date

  end
end