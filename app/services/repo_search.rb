require './app/services/repo'
require './app/services/github_service'

class RepoSearch
  # memoization
  def repo_information
      Repo.new(@_repo_information ||= service.repo)
  end

  def service
    GithubService.new
  end
  # binding.pry
end
