class GithubService
  def repo_name
    get_url("/repos")
  end

  def get_url(url)
    response = HTTParty.get("https://api.github.com/users/jhennerich#{url}")
    parsed = JSON.parse(response.body, symoblize_names: true)
  end

  def get_all_pull_requests
    response = HTTParty.get("https://api.github.com/repos/jhennerich/little-esty-shop/pulls?state=all")
    JSON.parse(response.body, symoblize_names: true)
  end

end
