class ApplicationController < ActionController::Base
  before_action :get_username, :get_commit, :get_pr #only: %i[index show new edit]

  # def get_repo
  #   @repo = RepoSearch.new.repo_information
  # end

  def get_username
    @usernames = UsernameSearch.new.username_information
  end

  def get_commit
    @commits = CommitSearch.new.commit_information
  end

  def get_pr
    @prs = PrSearch.new.pr_information
  end
end
