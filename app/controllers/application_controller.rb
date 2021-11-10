class ApplicationController < ActionController::Base

  def index
    #require "pry"; binding.pry
    @github_api = GithubService.new
  end

end
