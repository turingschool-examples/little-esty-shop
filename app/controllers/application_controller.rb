class ApplicationController < ActionController::Base
  before_action :names, :contributors

  def names
    json = GithubService.new.repos
    @repo_names = json[:name]
  end

  def contributors
    json = GithubService.new.contributors
    @repo_contributors = User.new(json).contributors
  end
end
