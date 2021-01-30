require 'spec_helper'

describe Spree::Rate do

  it 'has a valid factory' do
    expect(create(:rate)).to be_valid
  end

  # This method are from hotel gem, will stay here until migration
  %i[start_date end_date three_six_days seven_thirteen_days fourteen_twentynine_days].each do |method_name|
    it "should respond to the #{method_name}" do
      expect_any_instance_of(Spree::Rate).to receive(:get_persisted_option_value).with(method_name)
      Spree::Rate.new.send(method_name)
    end
  end

  context 'for end_date before start_date' do
    let(:start_date_option_value) { build_stubbed(:option_value) }
    let(:end_date_option_value) { build_stubbed(:option_value) }
    let(:rate) { build(:rate) }
    let(:start_date) { build(:rate_option_value,
                             value: Date.today + 1.day,
                             rate: rate,
                             option_value_id: start_date_option_value.id) }
    let(:end_date) { build(:rate_option_value,
                           value: Date.today,
                           rate: rate,
                           option_value_id: end_date_option_value.id) }

    it 'should raise a validation error' do
      allow(Spree::OptionValue).to receive(:find_by_name)
                               .with('start_date')
                               .and_return(start_date_option_value)

      allow(Spree::OptionValue).to receive(:find_by_name)
                               .with('end_date')
                               .and_return(end_date_option_value)
      rate.rate_option_values << start_date
      rate.rate_option_values << end_date

      expect(rate).to_not be_valid
      expect(rate.errors.messages[:end_date]).to eq ['must be after start date']
    end
  end

  context 'for dates overlaps' do
    let(:rate) { build(:rate) }
    let(:rate1) { build(:rate) }
    let(:today) { Date.today }
    let(:tomorrow) { Date.today + 1.day }

    it 'should raise a validation error' do
      allow(Spree::Rate).to receive(:where).and_return([rate1])
      allow_any_instance_of(Spree::Rate).to receive(:find_dates)
                                        .and_return([today,tomorrow])

      allow(rate1).to receive(:start_date).and_return(Date.today)
      allow(rate1).to receive(:end_date).and_return(Date.today + 1.day)

      expect(rate).to_not be_valid
      expect(rate.errors.messages[:overlaps]).to eq ['there is another rate with those days']
    end
  end
end