class GithubService

  def repo
    get_url("https://api.github.com/repos/Sierra-T-9598/little-esty-shop")
  end

  def contributors
    get_url("https://api.github.com/repos/Sierra-T-9598/little-esty-shop/contributors")
  end

  def commits
    get_url("https://api.github.com/repos/Sierra-T-9598/little-esty-shop/commits?per_page=100")
  end


  def pull_requests
    get_url("https://api.github.com/repos/Sierra-T-9598/little-esty-shop/pulls?state=closed&per_page=100")
  end


  def get_url(url)
    response = HTTParty.get(url)

    JSON.parse(response.body, symbolize_names: true)
  end

end
