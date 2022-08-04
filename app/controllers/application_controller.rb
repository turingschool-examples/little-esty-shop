class ApplicationController < ActionController::Base
  # before_action :before_anything_else
<<<<<<< HEAD
  #
=======

>>>>>>> 06560576609726cec69fbc8de0842dc59e8a6ab6
  # def before_anything_else
  #   @contributors = GithubFacade.contributors
  #   @pull_requests = GithubFacade.pull_requests
  #   @repo_name = GithubFacade.repo_name
  # end

  def index
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
