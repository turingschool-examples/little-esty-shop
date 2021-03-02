class ApplicationController < ActionController::Base
  before_action :contributors, :names

  def names
    json = GithubService.new.repos
    @repo_names = json[:name]
  end

  def contributors
    json = GithubService.new.contributors
    @repo_contributers =
    json.map do |data|
      data[:login]
    end
  end
end
