require './app/poros/repo'
require './app/services/github_service'

class GithubSearch
  def repo_information
    data = service.repo_name[:name]
    Repo.new(data)
  end

  def service
    GithubService.new
  end
end