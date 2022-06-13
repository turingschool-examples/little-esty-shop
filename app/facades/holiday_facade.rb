class HolidayFacade
  def self.find_holiday
    service.get_holidays.map do |one_holiday|
      Holiday.new(one_holiday)
    end
  end

  def self.service
    HolidayService.new
  end
end
