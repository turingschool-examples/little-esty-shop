class ApplicationController < ActionController::Base
  before_action :github_info

  def github_info
    @github_info = GithubFacade.info_hash
  end
end
