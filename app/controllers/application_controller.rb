class ApplicationController < ActionController::Base
  before_action :get_info,   only: [:index, :show, :new, :edit]

  def get_info
    @repo_name = GithubSearch.new.repo_information
    @contributors = GithubSearch.new.contributor_names
    @latest_pr = GithubSearch.new.num_pulls
  end
end
