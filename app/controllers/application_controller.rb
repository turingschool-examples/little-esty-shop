class ApplicationController < ActionController::Base
  before_action :github_data

  def github_data
    @repo_name = GithubFacade.new.repo
    @contributors = GithubFacade.new.contributors
    @pull_requests = GithubFacade.new.pull_requests
  end
end