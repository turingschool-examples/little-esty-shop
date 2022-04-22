class ApplicationController < ActionController::Base
  # before_action :repository_info, only: [:index, :show, :edit, :new]

  def welcome
  end

  def repository_info
    @repo = RepositoryFacade.repo_or_error_message
  end

  private

  def error_message(errors)
    errors.full_messages.join(", ")
  end
end
