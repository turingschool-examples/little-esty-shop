class RepoNames
  def self.tests
    # require 'faraday'
    # require 'json'
    # require 'pry'

    # response = Faraday.get("https://api.github.com/repos/Trevorsuter/little-esty-shop/collaborators")
    response = Faraday.get("https://api.github.com/repos/Trevorsuter/little-esty-shop/commits")
    json = JSON.parse(response.body, symbolize_names: true)
    # binding.pry
  end
end
