require 'httparty'

class GithubService
  def repos
    get_url("https://api.github.com/repos/aj-bailey/little-esty-shop")
  end

  def pulls
    get_url("https://api.github.com/repos/aj-bailey/little-esty-shop/pulls?state=closed")
  end

  def contributors
    get_url("https://api.github.com/repos/aj-bailey/little-esty-shop/contributors")
  end

  def get_url(url)
    response = HTTParty.get(url)
    parsed = JSON.parse(response.body, symbolize_names: true)
  end
end