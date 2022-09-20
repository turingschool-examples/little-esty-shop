require 'httparty'

class GithubService
  def repo_data
    get_url('https://api.github.com/repos/Rileybmcc/little-esty-shop')
  end

  def commits_data
    get_url('https://api.github.com/repos/Rileybmcc/little-esty-shop/commits')
  end

  def get_url(url)
    response = HTTParty.get(url)
    JSON.parse(response.body, symoblize_names: true)
  end
  
end
service = GithubService.new
require 'pry';binding.pry