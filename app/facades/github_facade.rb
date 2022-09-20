require 'json'
require_relative '../services/github_service'

class GitHubFacade

  def self.user_names
    response = GitHubService.request("collaborators")
    parsed = JSON.parse(response.body)
    # parsed.map { |user| user["login"] }.sort
  end
  
  def self.get_pr_total
    response = GitHubService.request("pulls")
    parsed = JSON.parse(response.body)
    # parsed[0]["number"]
  end
end