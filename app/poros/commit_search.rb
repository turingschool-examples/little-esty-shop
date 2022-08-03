require './app/poros/commit'
require './app/poros/git_service'
require 'pry'

class CommitSearch

  def commit_information
    service.commits.map do |data|
      Commit.new(data)
    end
  end

  def service
    GitService.new
  end
end
