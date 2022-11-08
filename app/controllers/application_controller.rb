class ApplicationController < ActionController::Base
  before_action :get_repo_name, only: [:index, :show, :new, :edit]
  def get_repo_name
    @repo_name = GithubSearch.new.repo_information
  end
end