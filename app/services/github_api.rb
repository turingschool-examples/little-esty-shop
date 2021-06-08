class GithubAPI

  def self.user_info(username, repo_name)
    response = Faraday.get "https://api.github.com/repos/#{username}/#{repo_name}"
    body = response.body
    JSON.parse(body, symbolize_names: true)
  end

  def self.contributors(username, repo_name)
    response = Faraday.get "https://api.github.com/repos/#{username}/#{repo_name}/contributors"
    body = response.body
    JSON.parse(body, symbolize_names: true)
  end

  # def self.commits(username, repo_name)
  #   response = Faraday.get "https://api.github.com/repos/#{username}/#{repo_name}/contributors"
  #   body = response.body
  #   JSON.parse(body, symbolize_names: true)
  # end

  def self.pull_requests(username, repo_name)
    response = Faraday.get "https://api.github.com/repos/#{username}/#{repo_name}/pulls?state=all&&is:merged"
    body = response.body
    JSON.parse(body, symbolize_names: true)
  end
end
