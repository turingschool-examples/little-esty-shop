class ApplicationController < ActionController::Base

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
