class ApplicationController < ActionController::Base
  before_action :service

  def service
    service = GithubService.new
    @contributors = service.contributors
    @commits = service.commits
    @pull_requests = service.pull_requests
  end
end
