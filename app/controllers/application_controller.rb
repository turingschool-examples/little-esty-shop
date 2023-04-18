#require './config/environment'

class ApplicationController < ActionController::Base
  def welcome
    # api_key = Rails.application.secrets.UNSPLASH_API_KEY
    api_key = Rails.application.config.unsplash_api_key
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
