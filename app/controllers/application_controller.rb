class ApplicationController < ActionController::Base
  before_action :set_logo
  
  def set_logo
    @logo_img = PhotoBuilder.logo_img
  end
  
  private
  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
