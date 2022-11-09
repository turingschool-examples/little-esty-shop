require './app/services/github_service'
require './app/poros/commit'
require 'pry'

class CommitSearch
  def commit_information
    service.commits.map do |data|
      Commit.new(data)
    end
  end

  def service
    GithubService.new
  end
end
