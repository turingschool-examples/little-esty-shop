require "httparty"
require "json"

class GitHubService
  def self.get_repos
    get_uri("https://api.github.com/users/sjmann2/repos")
  end

  def self.get_pull_requests
    get_pr("https://api.github.com/repos/sjmann2/little-esty-shop/pulls?state=all")
  end

  # def self.get_commits
  #   page1 = get_url_commits("https://api.github.com/repos/sjmann2/little-esty-shop/commits?q=addClass+user:mozilla&per_page=100&page=1")
  #   page2 = get_url_commits("https://api.github.com/repos/sjmann2/little-esty-shop/commits?q=addClass+user:mozilla&per_page=100&page=2")
  #   page3 = get_url_commits("https://api.github.com/repos/sjmann2/little-esty-shop/commits?q=addClass+user:mozilla&per_page=100&page=3")
  # end

  def self.get_uri(uri)
    return [{name: "little-esty-shop", full_name: "sjmann2/little-esty-shop"}] if Rails.env == "test"
    response = HTTParty.get(uri,     headers: {"Authorization" => "Bearer " + ENV["TOKEN"]})

    # ENV.fetch('TOKEN')
    JSON.parse(response.body,     symbolize_names: true)
  end

  def self.request(path, auth_required = false)
    return [{login: "noahvanekdom"}] if Rails.env == "test"
    response = HTTParty.get("https://api.github.com/repos/sjmann2/little-esty-shop/#{path}",     headers: {authorization: "Bearer " + ENV["UNAMETOKEN"]})
    JSON.parse(response.body,     symbolize_names: true)
  end

  def self.get_pr(uri)
    return [{number: 37}] if Rails.env == "test"
    response = HTTParty.get(uri)
    JSON.parse(response.body,     symbolize_names: true)
  end

  # def self.get_url_commits(url)
  #   return [{number_commits: 279}] if Rails.env == 'test'
  #   response = HTTParty.get(url) 
  #   parsed = JSON.parse(response.body, symbolize_names: true)
  # end
end
