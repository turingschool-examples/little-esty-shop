class GithubRepoService
  def get_url(url)
    response = HTTParty.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def repo_data
    get_url('https://api.github.com/repos/jimriddle1/little-esty-shop')
  end
end
