require 'github_service'
require 'json'

class GithubFacade
  def self.commits
    response = GithubService.commits
    parsed = JSON.parse(response.body)
    commits_arr = parsed.map do |commit|
      commit['committer']['login']
    end
    commits = commits_arr.tally
    commits.delete('web-flow')
    commits
  end

  
end