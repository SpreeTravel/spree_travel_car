### These are the option types
category = Spree::OptionType.find_by_name!("category")
transmision = Spree::OptionType.find_by_name!("transmision")

### This is the data
option_values = [
  {name: "economic", presentation: "Economic", option_type: category},
  {name: "standard", presentation: "Standard", option_type: category},
  {name: "luxary", presentation: "Luxary", option_type: category},
  {name: "van", presentation: "Van", option_type: category},
  {name: "automatic", presentation: "Automatic", option_type: transmision},
  {name: "mecanic", presentation: "Mecanic", option_type: transmision},
]

### Creating Option Values
option_values.each do |option_value|
  Spree::OptionValue.create(option_value)
end

