require './app/services/github_service'
require './app/poros/repo_name'

class RepoNameSearch
  def service
   GithubService.new
  end

  def repo_name_information
    RepoName.new(service.repo_name[:name])
  end
end