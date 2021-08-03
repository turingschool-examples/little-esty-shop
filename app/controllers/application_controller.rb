class ApplicationController < ActionController::Base
  before_action :api

  def api
    service = GithubService.new
    @contributors = service.contributors
    @commits = service.commits
  end
end
