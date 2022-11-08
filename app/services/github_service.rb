require 'httparty'

class GithubService
  def repo_name
    get_url("https://api.github.com/repos/josephhilby/little-esty-shop")
  end

  def get_url(url)
    response = HTTParty.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end