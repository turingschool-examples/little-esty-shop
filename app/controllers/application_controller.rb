class ApplicationController < ActionController::Base
  def admin
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end

end
