require 'github_api'

class Api::GithubApiController < ApplicationController

  def index
    @contributors = GithubApi.get_contributors
    @repo = GithubApi.get_repo
    @commits = GithubApi.get_commits
  end
end
