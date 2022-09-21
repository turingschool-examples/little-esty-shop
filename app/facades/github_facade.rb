require 'json'

class GitHubFacade

  def self.user_names
    response = GitHubService.request("collaborators", true)
    parsed = JSON.parse(response.body)
    parsed.map { |user| user["login"] }.sort
  end
  
  def self.get_pr_total
    response = GitHubService.request("pulls", false)
    parsed = JSON.parse(response.body)
    parsed[0]["number"]
    binding.pry

  end

  def self.user_commits
    response = GitHubService.request("commits", true)

  end
end 