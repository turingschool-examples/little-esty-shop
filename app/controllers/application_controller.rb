class ApplicationController < ActionController::Base
  # before_action :before_anything_else

  def before_anything_else
    # @contributors = GithubFacade.contributors
    # @pull_requests = GithubFacade.pull_requests
    # @repo_name = GithubFacade.repo_name
    # @holidays = NagerService.upcoming_holidays
    # @holidays = NagerFacade.holidays
  end

  def index
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
