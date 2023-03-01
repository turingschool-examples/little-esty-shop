require './app/poros/pull'
require './app/services/github_service'

class PullSearch
  def self.pull_count
    pulls = service.pulls.map do |data|
      Pull.new(data)
    end.count
  end

  def self.service
    GithubService.new
  end
end

# PullSearch.pull_info