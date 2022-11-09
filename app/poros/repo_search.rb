require './app/services/github_service'
require './app/poros/repo'

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