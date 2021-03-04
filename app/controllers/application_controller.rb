class ApplicationController < ActionController::Base
  before_action :names, :contributors, :pulls

  def names
    json = GithubService.new.repos
    @repo_names = Repo.new(json).name
  end

  def contributors
    json = GithubService.new.contributors
    @repo_contributors = User.new(json).contributors
  end

  def pulls
    json = GithubService.new.pulls
    @repo_pull_count = PullRequest.new(json).pull_requests
  end
end
