class SwaggerService < ApiService
  def holidays
    endpoint = 'https://date.nager.at/api/v3/NextPublicHolidays/US'
    get_data(endpoint)
  end
end