require 'httparty'

class HolidayService
  def self.holidays_data
    response = HTTParty.get("https://date.nager.at/api/v3/NextPublicHolidays/us")
    parsed_json = JSON.parse(response.body, symbolize_names: true)
  end

  def self.holiday_name
    holidays_data[0..2].map { |holiday| holiday[:name] }
  end

  def self.holiday_date
    holidays_data[0..2].map { |holiday| holiday[:date] }
  end
end