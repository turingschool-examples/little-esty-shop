class GithubsController < ApplicationController
  before_action :before_anything_else

  def before_anything_else
    @contributors = GithubFacade.contributors
    @pull_requests = GithubFacade.pull_requests
    @repo_name = GithubFacade.repo_name
  end
end