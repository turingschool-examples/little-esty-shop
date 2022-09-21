require_relative '../facades/github_facade'

class ApplicationController < ActionController::Base
  before_action :get_pr_total, :user_names, :repo_name
  
  private

  def user_names
    # @user_names = GitHubFacade.user_names
    @user_names = %w(test test test wooo test)
  end

  def get_pr_total
    # @pr_total = GitHubFacade.get_pr_total
    @pr_total = 50
  end

  def repo_name
    # @repo_name = GitHubFacade.repo_name
    @repo_name = 'little-esty-shop'
  end
end
