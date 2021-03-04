class GithubService < ApiService
  def repos
    repos_endpoint = "https://api.github.com/repos/klatour324/little-esty-shop"
    get_data(repos_endpoint)
  end

  def contributors
    repos_endpoint = "https://api.github.com/repos/klatour324/little-esty-shop/contributors"
    get_data(repos_endpoint)
  end

  def commits(username)
    repos_endpoint = "https://api.github.com/repos/klatour324/little-esty-shop/commits?author=#{username}"
    get_data(repos_endpoint)
  end

  def pulls
    repos_endpoint = "https://api.github.com/repos/klatour324/little-esty-shop/pulls?state==closed"
    get_data(repos_endpoint)
  end
end
