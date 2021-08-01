class WelcomeController < ApplicationController

  # def index
  #   @something = 'hello'
  # end

  def refresh
  #   @commits = API.aggregate_by_author(:commits)
  #   @pulls = API.aggregate_by_author(:pulls)
  #   # require "pry"; binding.pry
    redirect_back(fallback_location: root_path)
  end

end
