class ApplicationController < ActionController::Base
  before_action :repository_info, :contributors_info

  def welcome

  end

  def repository_info
    @repo = RepositoryFacade.repo_or_error_message
  end

  def contributors_info
    @contributors = ContributorsFacade.contributors_or_error_message
  end

  private

  def error_message(errors)
    errors.full_messages.join(", ")
  end
end
