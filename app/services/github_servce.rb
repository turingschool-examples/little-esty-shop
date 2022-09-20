require 'httparty'
require 'json'

class GithubService

  def self.get_repos
    get_uri('https://api.github.com/repos/Penitent0/little-esty-shop')
  end

  def self.get_uri(uri)
    data = HTTParty.get(uri)
    parsed = JSON.parse(data.body, symbolize_names: true)
  end
end
