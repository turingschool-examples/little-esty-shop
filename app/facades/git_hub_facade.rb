class GitHubFacade

  def self.contributors
    parsed = GitHubService.get_contributors
    parsed.map do |contributor_data|
      Contributor.new(contributor_data)
    end
  end

  def self.repo
    GitHubService.repo_name
  end

  def self.pulls
    parsed = GitHubService.pull_request
    parsed.map do |pull_data|
      PullRequest.new(pull_data)
    end
  end
end
