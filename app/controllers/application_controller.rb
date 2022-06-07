class ApplicationController < ActionController::Base
  def initialize
    @repo = GithubRepoFacade.new.full_repo
  end
end
