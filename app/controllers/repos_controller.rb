class ReposController < ApplicationController
  def index
    @repo = Repo.new
  end

end
