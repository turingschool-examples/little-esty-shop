require 'singleton'

class ApiInfo
  include Singleton

  def initialize
    @conn = Faraday.new(url: 'https://api.github.com/repos/cunninghamge/little-esty-shop')
  end

  def repo_name
    response = @conn.get
    body = JSON.parse(response.body, symbolize_names: true)
    repo_name = body[:name]
  end


end