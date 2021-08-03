class ApplicationController < ActionController::Base

  def index
    service = GithubService.new
    @contributors = service.contributors
  end
end
