require_relative '../facades/github_facade'

class ApplicationController < ActionController::Base
  before_action :user_names
  
  private

  def user_names
    @user_names = GitHubFacade.user_names
  end
end


