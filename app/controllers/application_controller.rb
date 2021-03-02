class ApplicationController < ActionController::Base
  before_action :contributors, :names

  def names
    json = GithubService.new.repos
    @repo_names = Repo.new(json).name
  end

  def contributors
    json = GithubService.new.contributors
    # @repo_contributers = Repo.new(json).login
  end
end
