class HolidayService

  def self.holidays
    conn = Faraday.new(url: 'https://date.nager.at/api/v3/')
    response = conn.get('nextpublicholidays/us')
    data = JSON.parse(response.body, symbolize_names: true)
  end
end
