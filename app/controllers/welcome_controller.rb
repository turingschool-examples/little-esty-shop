class WelcomeController < ApplicationController

  def refresh
    ApplicationController.reset_commits
    ApplicationController.reset_pulls
    if ApplicationController.rate_limit_hit?
      redirect_back(fallback_location: root_path, notice: "Github API Rate Limit Hit, Default Stats Temporarily Rendered")
    else
      redirect_back(fallback_location: root_path, notice: "Github API Statistics Successfully Refreshed")
    end
  end

end
