require './app/services/github_service'
require './app/poros/pr'
require 'pry'

class CommitSearch
  def pr_information
    service.prs.map do |data|
      Pr.new(data)
    end
  end

  def service
    GithubService.new
  end
end
