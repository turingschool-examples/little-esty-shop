class ApplicationController < ActionController::Base
  before_action :repo_info

  def repo_info
    @repo = GithubRepoFacade.new.full_repo
    @contributors = GithubRepoFacade.new.user_info
    @pull_request_count = GithubRepoFacade.new.count_pull_requests
  end
end
