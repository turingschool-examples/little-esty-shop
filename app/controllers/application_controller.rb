require_relative '../facades/github_facade'

class ApplicationController < ActionController::Base
  before_action :user_names, :get_pr_total
  
  private

  def user_names
    @user_names = GitHubFacade.user_names
  end

  def get_pr_total
    @pr_total = GitHubFacade.get_pr_total
  end
end


