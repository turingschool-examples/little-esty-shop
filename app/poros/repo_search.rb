require './app/services/github_service.rb'
require_relative 'repo'

class RepoSearch
  def self.repo_name
    Repo.new(service.repo)
  end
  
  def self.service
    GithubService.new
  end
end