require './app/facade/github'

class ApplicationController < ActionController::Base
  before_action :repo_name
  
  private

  def repo_name
    @repo_name = GitHubFacade.repo_name
  end
end
