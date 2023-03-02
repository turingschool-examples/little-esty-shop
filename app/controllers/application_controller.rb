class ApplicationController < ActionController::Base
  # layout "application"
  before_action :github_info
  add_flash_types :info, :error

  def github_info
    @github_info = GithubFacade.info_hash
  end

  private
  
  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
