require 'httparty'

class GitHubService
  GITHUB_URL = "https://api.github.com"

  def self.get_contributors
    get_uri("#{GITHUB_URL}/repos/RyanChrisSmith/little-esty-shop/contributors")
  end

  def self.get_uri(uri)
    response = HTTParty.get(uri)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.repo_name
    get_uri("#{GITHUB_URL}/repos/RyanChrisSmith/little-esty-shop")
  end

  def self.pull_request
    get_uri("#{GITHUB_URL}/repos/RyanChrisSmith/little-esty-shop/pulls?state=closed")
  end

end
