### This is the data
option_types = [
  {name: "start_date", presentation:  "Start Date", attr_type: 'date', travel: true, preciable: false },
  {name: "end_date",   presentation:  "End Date",   attr_type: 'date', travel: true, preciable: false },
  {name: 'three_six_days',   presentation:  "3 to 6 days",   attr_type: 'integer', travel: true, preciable: true},
  {name: 'seven_thirteen_days',  presentation:  "7 to 13 days",  attr_type: 'integer', travel: true, preciable: true },
  {name: 'fourteen_twentynine_days', presentation:  "14 to 29 days", attr_type: 'integer', travel: true, preciable: true },
  {name: "category",   presentation:  "Category",     attr_type: 'selection', travel: true, preciable: false },
  {name: "transmision", presentation:  "Transmision", attr_type: 'selection', travel: true, preciable: false },
  {name: "pickup_date", presentation:  "Pickup Date", attr_type: 'date', travel: true, preciable: false },
  {name: "return_date", presentation:  "Return Date", attr_type: 'date', travel: true, preciable: false },
  {name: "pickup_destination", presentation:  "Pickup Destination", attr_type: 'destination', travel: true, preciable: false },
  {name: "return_destination", presentation:  "Return Destination", attr_type: 'destination', travel: true, preciable: false },
  {name: "adult", presentation:  "Adult", attr_type: 'integer', short:'Adult', travel: true, preciable: false },
]

### Creating Option Types
option_types.each do |option_type|
  Spree::OptionType.where(name: option_type[:name]).first_or_create(presentation:  option_type[:presentation],
                                                                    attr_type: option_type[:attr_type],
                                                                    travel: option_type[:travel],
                                                                    preciable: option_type[:preciable])
end
