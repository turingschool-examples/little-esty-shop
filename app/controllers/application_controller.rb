class ApplicationController < ActionController::Base
  before_action :repo_name

  def repo_name
    @search = RepoSearch.new
  end
end
