require 'httparty'

class GithubService
  def repo_name
    get_url("https://api.github.com/repos/josephhilby/little-esty-shop")
  end

  def get_url(url)
    response = HTTParty.get(url, headers: {"Authorization" => "Bearer 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"})
    JSON.parse(response.body, symbolize_names: true)
  end
end