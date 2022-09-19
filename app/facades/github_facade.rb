require 'json'
require_relative '../services/github_service'

class GitHubFacade

  def self.user_names
    response = GitHubService.request("collaborators")
    parsed = JSON.parse(response.body)
    parsed.map { |user| user["login"] }.sort
  end
end