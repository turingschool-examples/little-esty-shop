class ApplicationController < ActionController::Base
  before_action :get_repo_name, only: %i[index show new edit]

  def get_repo
    @repo = RepoSearch.new.repo_information
  end

  def get_username
    @usernames = UsernameSearch.new.username_information
  end
end
