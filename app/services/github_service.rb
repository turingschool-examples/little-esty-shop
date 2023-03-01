require 'httparty'

class GithubService
  def contributors
    get_url( "https://api.github.com/repos/torienyart/little-esty-shop/contributors")
  end

  def commits
    get_url("https://api.github.com/repos/torienyart/little-esty-shop/commits?author=#{username}&per_page=100")
  end

  def prs
    get_url("https://api.github.com/repos/torienyart/little-esty-shop/pulls?state=closed")
  end

  def repo
    get_url("https://api.github.com/repos/torienyart/little-esty-shop")
  end

  def get_url(url) #Make a Get request
    response = HTTParty.get(url)
    parsed = JSON.parse(response.body, symbolize_names: true)
  end
end