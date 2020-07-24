# frozen_string_literal: true

module Spree
  module ContextDecorator
    def pickup_date(options = { temporal: true })
      get_mixed_option_value(:pickup_date, options)
    end

    def return_date(options = { temporal: true })
      get_mixed_option_value(:return_date, options)
    end

    def category(options = { temporal: true })
      get_mixed_option_value(:category, options)
    end
  end
end

Spree::Context.prepend Spree::ContextDecorator
