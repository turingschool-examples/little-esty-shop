class ApplicationController < ActionController::Base
  def initialize
    @repo = GithubRepoFacade.new.full_repo
    @contributors = GithubRepoFacade.new.user_info
  end
end
