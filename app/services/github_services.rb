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
    get_url("https://api.github.com/repos/ignored-comment/little-esty-shop/commits?")
  end

  def get_usernames
    get_collaborators.each do |collaborator|
      collaborator[:login]
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
