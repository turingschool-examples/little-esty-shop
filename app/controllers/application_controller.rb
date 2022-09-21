require 'github_facade'

class ApplicationController < ActionController::Base

  before_action :commits, :merged_pull_requests
  # private

  def commits
    @commits ||= GithubFacade.commits
  end

  def merged_pull_requests
    @prs ||= GithubFacade.pull_requests
  end

end
