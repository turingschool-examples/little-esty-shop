class NagerDateService

  attr_reader :names,
              :dates,
              :holidays

  def initialize
    @names ||= holiday_names
    @dates ||= holiday_dates
    @holidays ||= holidays
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

  def holidays
    holidays = {
      holiday_1: [@names[0], @dates[0]],
      holiday_2: [@names[1], @dates[1]],
      holiday_3: [@names[2], @dates[2]]
    }
  end
end
