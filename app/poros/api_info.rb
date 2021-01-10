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

  def contributors
    response = @conn.get("/repos/cunninghamge/little-esty-shop/contributors")
    body = JSON.parse(response.body, symbolize_names: true)
    body.map do |contributor|
      [contributor[:login], contributor[:contributions]]
    end
  end

  def merged_pull_request
    response = @conn.get("/repos/cunninghamge/little-esty-shop/pulls?state=closed")
    body = JSON.parse(response.body, symbolize_names: true)
    body.count do |pull|
      pull[:merged_at]
    end 
  end

end