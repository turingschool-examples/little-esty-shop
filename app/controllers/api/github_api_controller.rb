require 'github_api'

class Api::GithubApiController < ApplicationController

  def index
    @contributors = get_contributors
    @repo = get_repo
  end
end