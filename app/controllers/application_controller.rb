class ApplicationController < ActionController::Base
  before_action :get_info,   only: [:index, :show, :new, :edit]

  def get_info
    # @repo_name = GithubSearch.new.repo_information
    # contributors = GithubSearch.new.contributor_names
    # @contributors = contributors.sort_by {|contributor| contributor.num_commits}.last(6)
    # @latest_pr = GithubSearch.new.num_pulls

    @repo_name = Repo.new("little-esty-shop")
    @contributors = [Contributor.new({total: 13, author: {login: "ashuhleyt"}}), Contributor.new({total: 13, author: {login: "ashuhleyt"}}), Contributor.new({total: 13, author: {login: "ashuhleyt"}}), Contributor.new({total: 13, author: {login: "ashuhleyt"}}) ]
    @latest_pr = Pull.new({number: 37})
  end
end
