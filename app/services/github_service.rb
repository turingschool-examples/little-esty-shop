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