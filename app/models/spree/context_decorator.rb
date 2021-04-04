# frozen_string_literal: true

module Spree
  module ContextDecorator
    %i[
      product_type start_date end_date plan adult child
      cabin_count departure_date category pickup_destination
      return_destination pickup_date return_date category
    ].each do |method|
      define_method method do |temporal=nil|
        get_mixed_option_value(Spree::OptionType.select(:id, :name, :attr_type).find_by(name: method), temporal)
      end
    end
  end
end

Spree::Context.prepend Spree::ContextDecorator
