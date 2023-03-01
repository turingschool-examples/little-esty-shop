require 'httparty'

class GithubService
  def users
    get_url('https://api.github.com/repos/axeldelaguardia/little-esty-shop/collaborators', headers: {"Authorization" => "Bearer #{ENV["github_api_key"]}"})
  end

  def repo_name
    get_url('https://api.github.com/repos/axeldelaguardia/little-esty-shop', headers: {"Authorization" => "Bearer #{ENV["github_api_key"]}"})
  end

  def commits
		get_url('https://api.github.com/repos/axeldelaguardia/little-esty-shop/stats/contributors', headers: {"Authorization" => "Bearer #{ENV["github_api_key"]}"})
  end

  def pull_requests
    get_url('https://api.github.com/repos/axeldelaguardia/little-esty-shop/pulls?state=closed', headers: {"Authorization" => "Bearer #{ENV["github_api_key"]}"})
  end

  def get_url(url, token)
    response = HTTParty.get(url, token)
    parsed = JSON.parse(response.body, symbolize_names: true)
  end
end