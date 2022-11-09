class ApplicationController < ActionController::Base
  before_action :get_repo, :get_users, :get_pr_count #only: %i[index show new edit]

  def get_repo
    @repo_name = GithubService.new.repo_name
  end

  def get_users
    @users = GithubService.new.users
  end

  def get_pr_count
    @pr_count = GithubService.new.pr_count
  end
end
