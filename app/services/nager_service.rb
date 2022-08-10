require 'httparty'

class NagerService
    def self.upcoming_holidays
        response = HTTParty.get('https://date.nager.at/api/v3/NextPublicHolidays/us')

        body = response.body

        parsed = JSON.parse(body, symbolize_names: true)
    end
end
