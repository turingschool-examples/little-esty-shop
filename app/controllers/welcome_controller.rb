class WelcomeController < ApplicationController

  def refresh
    ApplicationController.reset_commits
    ApplicationController.reset_pulls
    redirect_back(fallback_location: root_path)
  end

end
