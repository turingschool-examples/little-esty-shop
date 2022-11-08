require './app/poros/repo'
require './app/poros/github_service'

class RepoSearch
  def create_repo
    Repo.new(service.repo_information)
  end

  def service
    GitHubService.new
  end
end
