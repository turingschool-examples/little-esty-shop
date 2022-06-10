class HolidayService

  def self.conn
    url = "https://date.nager.at/api/v3/NextPublicHolidays/us"
    Faraday.new(url: url)
  end

  def self.find_holidays
    response = conn.get
    JSON.parse(response.body, symbolize_names: true)
  end
end
