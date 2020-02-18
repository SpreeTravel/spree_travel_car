### These are the option types
category = Spree::OptionType.find_by_name!("category")
transmision = Spree::OptionType.find_by_name!("transmision")
pickup_destination = Spree::OptionType.find_by_name!("pickup_destination")
return_destination = Spree::OptionType.find_by_name!("return_destination")


### This is the data
option_values = [
  {name: "economic", presentation: "Economic", option_type: category},
  {name: "standard", presentation: "Standard", option_type: category},
  {name: "luxary", presentation: "Luxary", option_type: category},
  {name: "van", presentation: "Van", option_type: category},
  {name: "automatic", presentation: "Automatic", option_type: transmision},
  {name: "mecanic", presentation: "Mecanic", option_type: transmision},
  {name: "Pinar del Rio", presentation: "Pinar del Rio", option_type: pickup_destination },
  {name: "Artemisa", presentation: "Artemisa", option_type: pickup_destination },
  {name: "La Habana", presentation: "La Habana", option_type: pickup_destination },
  {name: "Mayabeque", presentation: "Mayabeque", option_type: pickup_destination },
  {name: "Isla de la Juventud", presentation: "Isla de la Juventud", option_type: pickup_destination },
  {name: "Matanzas", presentation: "Matanzas", option_type: pickup_destination },
  {name: "Villa Clara", presentation: "Villa Clara", option_type: pickup_destination },
  {name: "Cienfuegos", presentation: "Cienfuegos", option_type: pickup_destination },
  {name: "Sancti Spiritus", presentation: "Sancti Spiritus", option_type: pickup_destination },
  {name: "Ciego de Avila", presentation: "Ciego de Avila", option_type: pickup_destination },
  {name: "Camaguey", presentation: "Camaguey", option_type: pickup_destination },
  {name: "Las Tunas", presentation: "Las Tunas", option_type: pickup_destination },
  {name: "Holguin", presentation: "Holguin", option_type: pickup_destination },
  {name: "Granma", presentation: "Granma", option_type: pickup_destination },
  {name: "Santiago de Cuba", presentation: "Santiago de Cuba", option_type: pickup_destination },
  {name: "Guantanamo", presentation: "Guantanamo", option_type: pickup_destination },
  {name: "Pinar del Rio", presentation: "Pinar del Rio", option_type: return_destination },
  {name: "Artemisa", presentation: "Artemisa", option_type: return_destination },
  {name: "La Habana", presentation: "La Habana", option_type: return_destination },
  {name: "Mayabeque", presentation: "Mayabeque", option_type: return_destination },
  {name: "Isla de la Juventud", presentation: "Isla de la Juventud", option_type: return_destination },
  {name: "Matanzas", presentation: "Matanzas", option_type: return_destination },
  {name: "Villa Clara", presentation: "Villa Clara", option_type: return_destination },
  {name: "Cienfuegos", presentation: "Cienfuegos", option_type: return_destination },
  {name: "Sancti Spiritus", presentation: "Sancti Spiritus", option_type: return_destination },
  {name: "Ciego de Avila", presentation: "Ciego de Avila", option_type: return_destination },
  {name: "Camaguey", presentation: "Camaguey", option_type: return_destination },
  {name: "Las Tunas", presentation: "Las Tunas", option_type: return_destination },
  {name: "Holguin", presentation: "Holguin", option_type: return_destination },
  {name: "Granma", presentation: "Granma", option_type: return_destination },
  {name: "Santiago de Cuba", presentation: "Santiago de Cuba", option_type: return_destination },
  {name: "Guantanamo", presentation: "Guantanamo", option_type: return_destination },
]

### Creating Option Values
option_values.each do |option_value|
  Spree::OptionValue.create(option_value)
end

