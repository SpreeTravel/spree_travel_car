# frozen_string_literal: true

# frozen_string_literal: true.

module Spree
  module RateDecorator
    def three_six_days
      get_persisted_option_value(:three_six_days)
    end

    def seven_thirteen_days
      get_persisted_option_value(:seven_thirteen_days)
    end

    def fourteen_twentynine_days
      get_persisted_option_value(:fourteen_twentynine_days)
    end
  end
end

Spree::Rate.prepend Spree::RateDecorator
