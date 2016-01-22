### This is the data
option_types = [
  {:name => "start_date", :presentation => "Start Date", :attr_type => 'date'},
  {:name => "end_date",   :presentation => "End Date",   :attr_type => 'date'},
  {:name => 'three_six_days',   :presentation => "3 to 6 days",   :attr_type => 'integer'},
  {:name => 'seven_thirteen_days',  :presentation => "7 to 13 days",  :attr_type => 'integer'},
  {:name => 'fourteen_tuentynine_days', :presentation => "14 to 29 days", :attr_type => 'integer'},
  {:name => "category",   :presentation => "Category",     :attr_type => 'selection'},
  {:name => "transmision", :presentation => "Transmision", :attr_type => 'selection'},
  {:name => "pickup_date", :presentation => "Pickup Date", :attr_type => 'date'},
  {:name => "return_date", :presentation => "Return Date", :attr_type => 'date'},
  {:name => "pickup_destination", :presentation => "Pickup Destination", :attr_type => 'destination'},
  {:name => "return_destination", :presentation => "Return Destination", :attr_type => 'destination'},
  {:name => "adult", :presentation => "Adult", :attr_type => 'integer', :short => 'Adult'},
]

### Creating Option Types
option_types.each do |ot|
  Spree::OptionType.where(:name => ot[:name]).first_or_create(:presentation => ot[:presentation], :attr_type => ot[:attr_type])
end
