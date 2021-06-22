# frozen_string_literal: true

module Spree
  module ContextDecorator
    %i[category pickup_destinationpickup_date
       return_destination return_date adult pickup_date return_date].each do |method|
      define_method method do |temporal = nil|
        get_mixed_option_value(Spree::OptionType.select(:id, :name, :attr_type).find_by(name: method), temporal)
      end
    end
  end
end

Spree::Context.prepend Spree::ContextDecorator
