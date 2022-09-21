require "./app/facade/github_facade"

class ApplicationController < ActionController::Base
  before_action :user_names, :repo_name, :get_pr

  private

  def user_names
    @user_names = GitHubFacade.user_names
  end

  def repo_name
    @repo_name = GitHubFacade.repo_name
  end


  def get_pr
    @repo_pr_number = GitHubFacade.pull_requests
  end

  # def commits
  #   @commits = GitHubFacade.all_commits
  # end
end
