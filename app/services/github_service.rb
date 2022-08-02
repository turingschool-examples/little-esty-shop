require 'httparty'
require 'pry'

class GithubService

  def repo
    get_url("https://api.github.com/repos/okayama-mayu/little-esty-shop")
  end


  def get_url(url)
    response = HTTParty.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
  # binding.pry
end
