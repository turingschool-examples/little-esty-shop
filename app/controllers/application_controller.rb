require './lib/git_repo'

class ApplicationController < ActionController::Base
  before_action :repo_info, :only => [:index, :show, :edit, :new]

  def repo_info
    repo_call = GitRepo.new
    @repository_name = repo_call.repo_name
    @group_usernames = repo_call.usernames
    @contributor_commits = repo_call.commits_by_contributors
    @pull_requests = repo_call.number_of_pull_requests
  end
end
