require 'httparty'

class GitHubService
  def self.get_contributors
    get_uri("https://api.github.com/repos/RyanChrisSmith/little-esty-shop/contributors")
  end

  def self.get_uri(uri)
    response = HTTParty.get(uri)
    parsed = JSON.parse(response.body, symbolize_names: true)
  end

end