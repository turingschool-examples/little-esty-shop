class ApplicationController < ActionController::Base
  def show
    @github = GithubFacade.get_users
  end
end
