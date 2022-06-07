class GithubService < BaseService

  def self.get_repo_data
    response = conn('https://api.github.com').get('/repos/ruezheng/little-esty-shop')
    get_json(response)
  end
end
