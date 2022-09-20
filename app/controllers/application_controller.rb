class ApplicationController < ActionController::Base
  before_action :fetch_github_service

  def fetch_github_service
    @contributors = GitHubFacade.contributors
  end
end
