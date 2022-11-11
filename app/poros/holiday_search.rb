require "./app/poros/holiday"
require "./app/services/holiday_service"

class HolidaySearch
  def upcoming_holidays
    service.holidays.map do |data|
      Holiday.new(data)
    end
  end

  def service
    HolidayService.new
  end
end
