class ApplicationController < ActionController::Base
  # before_action :initialize_api
  # before_action :initialize_repo
  # before_action :initialize_contributors
  # before_action :initialize_commits
  # before_action :initialize_pull_requests


  def initialize_api
    GithubService.new
  end

  def initialize_repo
    @repo = Repo.new(initialize_api.repo[:name])
  end

  def initialize_commits
    @commits = initialize_api.commits.map do |data|
      Commit.new(data)
    end
  end

  def initialize_contributors
    @contributors = initialize_api.contributors.map do |data|
      UserInfo.new(data)
    end
  end

  def initialize_pull_requests
    @pull_requests = initialize_api.pull_requests.map do |data|
      PullRequest.new(data)
    end
  end
end
