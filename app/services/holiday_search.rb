require_relative "./holiday_service"
# this exists to make plain old ruby objects (POROS)
# performs any "business logic" that needs to be performed
# It transforms the data into what your controller is going to need
class HolidaySearch

  def holiday_information
    service.holidays.map do |data|
      Holiday.new(data)
    end
  end

  # by testing this method, we are starting a chain reation that ensures the other methods and classes are working.
  # (integration test)
  def next_three_holidays
    holiday_information[0..2]
  end

  def service
    HolidayService.new
  end
end