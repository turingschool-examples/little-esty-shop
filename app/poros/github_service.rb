require 'httparty'

class GitHubService
  def repo_information
    get_url('https://api.github.com/repos/eport01/little-esty-shop')
  end

  def collaborators_information
    get_url('https://api.github.com/repos/eport01/little-esty-shop/collaborators')
  end

  def pr_info
    get_url('https://api.github.com/repos/eport01/little-esty-shop/pulls')
  end

  def get_url(url)
    response = HTTParty.get(url, headers: { 'Authorization' => 'Bearer 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' })
    parsed = JSON.parse(response.body, symbolize_names: true)
  end
end