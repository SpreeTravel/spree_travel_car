require 'spec_helper'

describe Spree::Context, type: :model do

  %i[
      product_type start_date end_date plan adult child
      cabin_count departure_date category pickup_destination
      return_destination pickup_date return_date category
    ].each do |method_name|
    it "should respond to the #{method_name}" do
      allow_any_instance_of(Spree::Context).to receive(:persisted_option_value).with(method_name)
      Spree::Context.new.send(method_name, {temporal: nil})
    end
  end

end