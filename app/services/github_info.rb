require 'github_service.rb'
class GithubInfo
  def initialize
    @repo = GithubService.new("/repos/sambcox/little-esty-shop").get_url
    @collaborators = GithubService.new("/repos/sambcox/little-esty-shop/collaborators").get_url
    @contributors = GithubService.new("/repos/sambcox/little-esty-shop/contributors").get_url
    @pull_requests = GithubService.new("/repos/sambcox/little-esty-shop/pulls?state=all&per_page=100").get_url
  end

  def repo_name
    @repo[:full_name]
  end

  def user_names
    @collaborators.map do |collaborator|
      collaborator[:login]
    end
  end

  def commits_per_collaborator
    commits = Hash.new
    @contributors.each do |contributor|
      next unless user_names.include?(contributor[:login])
      commits[contributor[:login]] = contributor[:contributions]
    end
    commits
  end

  def pr_count
    @pull_requests.count
  end
end