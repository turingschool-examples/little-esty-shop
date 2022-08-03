class ApplicationController < ActionController::Base

  def index
  end
  
  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
