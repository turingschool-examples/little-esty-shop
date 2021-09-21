require 'faraday'
require 'json'
require 'pry'


class RepoService
  def repo_name
    get_url("/repos/equinn125/little-esty-shop")
  end

  def contributors
    get_url("/repos/equinn125/little-esty-shop/stats/contributors")
  end

  def pull_requests
    get_url("/repos/equinn125/little-esty-shop/pulls")
  end

  def get_url(url)
    response = Faraday.get(url)
    JSON.parse(response.body, symoblize_names: true)
  end
end
