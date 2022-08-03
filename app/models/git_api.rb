class GitApi < ApplicationRecord

  def self.make_request
    response = HTTParty.get("https://api.github.com/repos/jaredhardinger/little-esty-shop")
    JSON.parse(response.body, symbolize_names: true)
  end
end