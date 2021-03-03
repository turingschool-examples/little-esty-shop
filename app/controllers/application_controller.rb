class ApplicationController < ActionController::Base
  before_action :names, :contributors, :commits

  def names
    json = GithubService.new.repos
    @repo_names = json[:name]
  end

  def contributors
    json = GithubService.new.contributors
    @repo_contributors = User.new(json).contributors
  end

  # def commits
  #   json = GithubService.new.commits
  #   @repo_commits = Commit.new(json)
  # end
end
