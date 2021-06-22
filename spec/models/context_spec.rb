require 'spec_helper'

describe Spree::Context, type: :model do

  %i[category pickup_destinationpickup_date
     return_destination return_date adult pickup_date return_date].each do |method_name|
    it "should respond to the #{method_name}" do
      expect_any_instance_of(Spree::Context).to receive(:get_mixed_option_value)
                                           .with(Spree::OptionType.select(:id, :name, :attr_type).find_by(name: method_name), temporal=nil)
      Spree::Context.new.send(method_name)
    end
  end

end