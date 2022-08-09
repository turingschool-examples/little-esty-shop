require './lib/holiday_service'

class HolidaySearch
  def holiday_information
    @holiday_information = service.holidays.first(3).map
    # binding.pry
  end

  def service
    HolidayService.new
  end
end