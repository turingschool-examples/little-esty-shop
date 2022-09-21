
class RepoSearch
  def self.all_repos
    repo_data ||= GithubService.get_repos
    Repo.new(repo_data)
  end

  def self.total_merged_pulls
    repo_data ||= GithubService.get_total_pulls
    PullRequest.new(repo_data)
  end

  def self.users 
    repo_data ||= GithubService.get_contributors
    repo_data[0..4].map do |user|
      Contributor.new(user)
    end
  end
end
