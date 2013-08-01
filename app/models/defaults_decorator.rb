Defaults.class_eval do

  def self.check_in_car
    Time.now
  end

  def self.check_out_rent
    Time.now + 1.days
  end
end
