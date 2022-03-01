class ApplicationController < ActionController::Base

  def repo_name
    @repo_name = RepoNameFacade.find_repo_name
  end

  def contributors
    @contributors = ContributorFacade.find_contributor
  end
end
