class NagerDateService

  attr_reader :names,
              :dates

  def initialize
    @names ||= holiday_name
    @dates ||= holiday_date
  end

  def holiday_names
    response = Faraday.get 'https://date.nager.at/api/v2/NextPublicHolidays/us'
    parsed = JSON.parse(response.body, symbolize_names: true)
    names = [parsed[0][:name], parsed[1][:name], parsed[2][:name]]
  end

  def holiday_dates
    response = Faraday.get 'https://date.nager.at/api/v2/NextPublicHolidays/us'
    parsed = JSON.parse(response.body, symbolize_names: true)
    names = [parsed[0][:date], parsed[1][:date], parsed[2][:date]]
  end

end
