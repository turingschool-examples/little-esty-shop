class ApplicationController < ActionController::Base

  def contributors
    @contributors = ContributorFacade.find_contributor
  end
end
