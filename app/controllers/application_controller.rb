class ApplicationController < ActionController::Base
  before_action :api

  def api
    @service = GithubService.new
    binding.pry
    @repo = RepoName.new(@service.repo_name)
    @repo_pr = RepoPullRequests.new
    @contributors = ContributorNames.new(@service.contributors)
  end
end
