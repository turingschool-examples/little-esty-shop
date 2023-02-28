require 'httparty'

class GithubService
  def users
    get_url ('https://api.github.com/repos/axeldelaguardia/little-esty-shop', headers: {"Authorization" => "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"})
  end

  def repo_name
    # get_url()
  end

  def commits
    # get_url()
  end

  def pull_requests
    # get_url()
  end

  def get_url(url)
    response = HTTParty.get(url)
    parsed = JSON.parse(response.body, symbolize_names: true)
  end
end