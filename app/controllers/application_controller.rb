class ApplicationController < ActionController::Base

  def repo_name
    @repo_name = RepoNameFacade.find_repo_name
  end

  def contributors
    @contributors = ContributorFacade.find_contributor
  end

  def num_pull_requests# {[user1, 13] [user2, 42]}
    @users_with_pr = ContributorFacade.num_pull_requests
  end
end
