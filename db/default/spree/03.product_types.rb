### This is the data
rates = ['start_date', 'end_date', 'three_six_days', 'seven_thirteen_days', 'fourteen_tuentynine_days']
contexts = ['category', 'pickup_destination','pickup_date', 'return_destination', 'return_date', 'adult']
variants = ['category', 'transmision']

rate_option_types = rates.each.map {|r| Spree::OptionType.find_by_name(r)}
context_option_types = contexts.each.map {|c| Spree::OptionType.find_by_name(c)}
variant_option_types = variants.each.map {|v| Spree::OptionType.find_by_name(v)}

### Creating Product Type if not created
Spree::ProductType.where(:name => 'car').first_or_create(
   :presentation => 'Car',
   :rate_option_types => rate_option_types,
   :context_option_types => context_option_types,
   :variant_option_types => variant_option_types
)
