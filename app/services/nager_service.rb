# require 'httparty'
#
# class NagerService
#     def self.upcoming_holidays
#         response = HTTParty.get('https://date.nager.at/swagger/index.html')
#
#         body = response.body
#
#         parsed = JSON.parse(body, symbolize_names: true)
#         require "pry"; binding.pry
#     end
# end
