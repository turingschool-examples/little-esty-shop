require './app/poros/repo'
require './app/services/github_service'

class RepoSearch
  def repo_information
    service.repos.map do |data|
      Repo.new(data)
    end
  end

  def service
    GithubService.new
  end
end