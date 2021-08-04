class GithubService < ApiService
  def repos
    endpoint = 'https://api.github.com/repos/gunnarrunner/little-esty-shop'
    get_data(endpoint)
  end
end