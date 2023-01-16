class HolidayService
# this grabs the information from the api needed
  def holidays
    response = get_url("https://date.nager.at/api/v3/NextPublicHolidays/US")
    parsed = JSON.parse(response.body, symbolize_names: true)
  end

  # this keeps it dynamic if I need to get info from multiple urls.
  def get_url(url)
    response = HTTParty.get(url)
  end
end