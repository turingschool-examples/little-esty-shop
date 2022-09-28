require 'github_service'
require 'json'

class GithubFacade

  def self.commits
    users = ["gjcarew", "KevinT001", "stephenfabian", "Rileybmcc"]
    parsed = users.map do |user|
      response = GithubService.commits(user)
      JSON.parse(response.body, symbolize_names: true)
    end.flatten
    commits_arr = parsed.map do |commit|
      commit[:committer][:login]
    end
    commits = commits_arr.tally
    commits.delete("web-flow")
    commits
  end

  def self.pull_requests
    response = GithubService.pull_requests
    parsed = JSON.parse(response.body)
    pr_count = parsed.count do |pr|
      pr["merged_at"] != nil
    end
    pr_count
  end

end
