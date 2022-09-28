require 'httparty'
require 'pry'

class SwaggerService
  def self.next_holidays
    HTTParty.get("https://date.nager.at/api/v3/NextPublicHolidays/US")
  end
  
end
