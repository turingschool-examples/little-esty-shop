require 'github_service'
require 'json'
require 'pry'

class SwaggerFacade

  def self.next_3
    response = SwaggerService.next_holidays
    parsed = JSON.parse(response.body, symbolize_names: true).first(3)
    parsed.map {|day| [day[:name], day[:date]]}
  end

end
