require 'json'
require 'httparty'
class GithubService

  def initialize(url)
    @url = url
  end

  def get_url
    response = HTTParty.get("https://api.github.com#{@url}", headers: {"User-Agent" => "sambcox", "Authorization" => "token #{github_auth_token}"})
    parsed = JSON.parse(response.body, symbolize_names: true)
  end

private
  def github_auth_token
    Rails.application.credentials.config[:github]
  end
end