require_relative '../facades/github_facade'

class ApplicationController < ActionController::Base
  before_action :get_pr_total, :user_names
  
  private

  def user_names
    # @user_names = GitHubFacade.user_names
    @user_names = %w[astrid aj jake alaina]
  end

  def get_pr_total
    # @pr_total = GitHubFacade.get_pr_total
    @pr_total = 75
  end
end
