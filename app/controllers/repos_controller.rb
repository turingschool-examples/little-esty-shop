class ReposController < ApplicationController
  def index
    @repo = GithubApi.new
  end

end
