require 'faraday'
require 'json'

class UpcomingHolidaysServices
  def get_url(url)
    response = Faraday.get(url)
    data = response.body
    JSON.parse(data, symbolize_names: true)
  end

  def holidays
    holidays = get_url("https://date.nager.at/Api/v2/NextPublicHolidays/US")
    holidays.take(3)
  end
end
