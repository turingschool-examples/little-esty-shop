require 'json'
require './app/services/github_service'

class GitHubFacade

  def self.user_names
    response = GitHubService.request("collaborators", true)

    parsed = JSON.parse(response.body)

    parsed.map { |user| user["login"] }.sort

  end
  
  def self.get_pr_total
    response = GitHubService.request("pulls?state=closed", false)
    parsed = JSON.parse(response.body)
    parsed[0]["number"]
  end

  def self.user_commits
    response = GitHubService.request("commits", false)
    parsed = JSON.parse(response.body)
    hash = Hash.new(0)
    parsed.each do |commit|
      hash[commit["author"]["login"]] += 1
    end
    return hash
  end
end 

