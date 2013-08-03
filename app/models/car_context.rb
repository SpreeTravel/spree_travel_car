class CarContext < Context

  def initialize(params)
    @check_in = params[:date_check_in_car]
    @check_out = params[:date_check_out_car]
    @transmission = params[:transmission_car]
  end

  def check_in
    (@check_in || Defaults.check_in_car).to_date
  end

  def check_out
    (@check_out || Defaults.check_out_car).to_date
  end

  def duration
    check_out - check_in
  end

  def transmission_id
    @transmission
  end

end
