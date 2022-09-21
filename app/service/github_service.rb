require 'httparty'
require 'json'

class GitHubService

  def self.get_repos
    get_uri("https://api.github.com/users/sjmann2/repos")
  end

  def self.get_uri(uri)
    return [{name: 'little-esty-shop', full_name: 'sjmann2/little-esty-shop'}] if Rails.env == 'test'
    response = HTTParty.get(uri, headers: {"Authorization" => "Bearer "+ENV["TOKEN"]})
    # ENV.fetch('TOKEN')
    JSON.parse(response.body, symbolize_names: true)
  end
end
