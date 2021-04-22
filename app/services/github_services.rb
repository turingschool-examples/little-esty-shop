require 'faraday'
require 'json'

class GithubServices
  def get_repo_name
    get_url("https://api.github.com/repos/ignored-comment/little-esty-shop")[:name]
  end

  def get_collaborators
    get_url("https://api.github.com/repos/ignored-comment/little-esty-shop/collaborators")
  end

  def get_commits
    contributor = get_url("https://api.github.com/repos/ignored-comment/little-esty-shop/contributors")

    contributor.each do |contributor|
      contributor[:login]
      contributor[:contributions]
    end
  end

  token = ENV['GITHUB_TOKEN']

  def get_url(url)
    response = Faraday.get(url) do |req|
      req.headers['Authorization'] = "token #{ENV['GITHUB_TOKEN']}"
    end
    data = response.body
    JSON.parse(data, symbolize_names: true)
  end
end
