class WelcomeController < ApplicationController

  def refresh
    @default_commits = API.contributions[:defaults][:commits]
    @default_pulls = API.contributions[:defaults][:pulls]
    # @refreshed_commits = API.aggregate_by_author(:commits)
    # @refreshed_pulls = API.aggregate_by_author(:pulls)
    # if @refreshed_commits.values.sum { |val| val } == 0
    #   @refreshed_commits = @default_commits
    # end
    # if @refreshed_pulls.values.sum { |val| val } == 0
    #   @refreshed_pulls = @default_pulls
    # end
    redirect_back(fallback_location: root_path)
  end

end
