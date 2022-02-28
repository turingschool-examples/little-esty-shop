class ApplicationController < ActionController::Base
  def repo_name
    @repo_name = RepoNameFacade.find_repo_name

  def contributors
    @contributors = ContributorFacade.find_contributor
  end
end
