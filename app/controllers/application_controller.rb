require 'github_facade'

class ApplicationController < ActionController::Base
  before_action :commits
  private

  def commits
    @commits ||= GithubFacade.commits
  end
end
