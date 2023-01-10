require 'json'
require 'httparty'
class GithubService

  def initialize(url)
    @url = url
  end

  # def repo
  #   url = get_url("https://api.github.com/repos/sambcox/little-esty-shop")
  # end

  # def contributors
  #   url = get_url("https://api.github.com/repos/sambcox/little-esty-shop/contributors")
  # end

  # def commits
  #   url = get_url("https://api.github.com/repos/sambcox/little-esty-shop/commits?per_page=100")
  #   url_2 = get_url("https://api.github.com/repos/sambcox/little-esty-shop/commits?per_page=70&page=2")
  # end

  # def merges
  #   url = get_url("https://api.github.com/repos/sambcox/little-esty-shop/")
  # end

  def get_url
    response = HTTParty.get("https://api.github.com#{@url}", headers: {"User-Agent" => "sambcox", "Authorization" => "token #{github_auth_token}"})
    parsed = JSON.parse(response.body, symoblize_names: true)
  end

private
  def github_auth_token
    Rails.application.credentials.config[:github]
  end
end