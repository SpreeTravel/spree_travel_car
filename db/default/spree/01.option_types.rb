### This is the data
option_types = [
  {name: "start_date", presentation:  "Start Date", attr_type: 'date', travel: true },
  {name: "end_date",   presentation:  "End Date",   attr_type: 'date', travel: true },
  {name: 'three_six_days',   presentation:  "3 to 6 days",   attr_type: 'price', travel: true},
  {name: 'seven_thirteen_days',  presentation:  "7 to 13 days",  attr_type: 'price', travel: true },
  {name: 'fourteen_twentynine_days', presentation:  "14 to 29 days", attr_type: 'price', travel: true },
  {name: "category",   presentation:  "Category",     attr_type: 'selection', travel: true },
  {name: "transmission", presentation:  "Transmission", attr_type: 'selection', travel: true },
  {name: "pickup_date", presentation:  "Pickup Date", attr_type: 'date', travel: true },
  {name: "return_date", presentation:  "Return Date", attr_type: 'date', travel: true },
  {name: "pickup_destination", presentation:  "Pickup Destination", attr_type: 'destination', travel: true },
  {name: "return_destination", presentation:  "Return Destination", attr_type: 'destination', travel: true },
  {name: "adult", presentation:  "Adult", attr_type: 'pax', short:'Adult', travel: true },
]

### Creating Option Types
option_types.each do |option_type|
  Spree::OptionType.where(name: option_type[:name]).first_or_create(presentation:  option_type[:presentation],
                                                                    attr_type: option_type[:attr_type],
                                                                    travel: option_type[:travel],
                                                                    preciable: option_type[:preciable])
end
