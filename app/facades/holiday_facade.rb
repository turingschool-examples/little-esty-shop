class HolidayFacade
  def self.three_holidays
    data = HolidayService.holidays
    holidays = []
    data.each do |holiday|
       holidays << Holiday.new(holiday)
    end
    holidays.first(3)
  end
end
