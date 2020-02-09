module Spree::RateDecorator

    def three_six_days
      get_persisted_option_value(:three_six_days).to_i
    end

    def seven_thirteen_days
      get_persisted_option_value(:seven_thirteen_days).to_i
    end

    def fourteen_twentynine_days
      get_persisted_option_value(:fourteen_twentynine_days).to_i
    end

end

Spree::Rate.prepend Spree::RateDecorator