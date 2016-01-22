Spree::Context.class_eval do

  def pickup_date(options = {:temporal => true})
    get_mixed_option_value(:pickup_date, options)
  end

  def return_date(options = {:temporal => true})
    get_mixed_option_value(:return_date, options)
  end

  def category(options = {:temporal => true})
    get_mixed_option_value(:category, options)
  end



end
