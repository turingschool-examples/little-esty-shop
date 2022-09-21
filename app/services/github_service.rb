require 'httparty'
require 'json'

class GithubService

  def get_repos
    get_uri('https://api.github.com/repos/Penitent0/little-esty-shop')
  end

  def get_total_pulls
    get_uri('https://api.github.com/search/issues?q=repo:Penitent0/little-esty-shop%20type:pr%20is:merged')
  end

  def get_contributors
    get_uri('https://api.github.com/repos/Penitent0/little-esty-shop/contributors')
  end

  def get_uri(uri)
    data = HTTParty.get(uri)
    parsed = JSON.parse(data.body, symbolize_names: true)
  end
end
