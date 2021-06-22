require 'spec_helper'

describe Spree::Rate, type: :model do

  %i[start_date end_date three_six_days
      seven_thirteen_days fourteen_twentynine_days].each do |method_name|
    it "should respond to the #{method_name}" do
      expect_any_instance_of(Spree::Rate).to receive(:persisted_option_value)
      Spree::Rate.new.send(method_name)
    end
  end

  context 'dates validation' do
    let(:start_date_option_type) { create(:option_type_decorated, name: 'start_date', attr_type: 'date') }
    let(:end_date_option_type) { create(:option_type_decorated, name: 'end_date', attr_type: 'date') }

    let(:start_date_option_value) { create(:option_value, option_type: start_date_option_type, name: 'date', presentation: 'Date') }
    let(:end_date_option_value) { create(:option_value, option_type: end_date_option_type, name: 'date', presentation: 'Date') }

    let(:start_date_rate_option_value) { create(:rate_option_value, option_value: start_date_option_value, rate: nil) }
    let(:end_date_rate_option_value) { create(:rate_option_value, option_value: end_date_option_value, rate: nil) }

    let!(:start_date_value) { create(:value, valuable: start_date_rate_option_value, date: Date.today + 1.day) }
    let!(:end_date_value) { create(:value, valuable: end_date_rate_option_value, date: Date.today) }

    let(:rate) { build(:rate, rate_option_values: []) }

    before do
      allow(Spree::OptionValue).to receive(:find_by_name)
                                     .with('start_date')
                                     .and_return(start_date_option_value)
      allow(Spree::OptionValue).to receive(:find_by_name)
                                     .with('end_date')
                                     .and_return(end_date_option_value)

      rate.rate_option_values << start_date_rate_option_value
      rate.rate_option_values << end_date_rate_option_value

    end

    context 'for end_date before start_date' do
      it 'rate is not valid' do
        expect(rate).to_not be_valid
      end

      it 'should raise a validation error' do
        rate.valid?

        expect(rate.errors.messages[:end_date]).to eq ['must be after start date']
      end
    end

    context 'for dates overlaps' do
      let(:rate1) { build(:rate) }

      it 'should raise a validation error' do
        allow(Spree::Rate).to receive(:where).and_return([rate1])

        allow(rate1).to receive(:start_date).and_return(Date.today)
        allow(rate1).to receive(:end_date).and_return(Date.today + 1.day)

        expect(rate).to_not be_valid
        expect(rate.errors.messages[:overlaps]).to eq ['there is another rate with those days']
      end
    end
  end
end