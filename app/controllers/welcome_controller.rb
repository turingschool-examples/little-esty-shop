class WelcomeController < ApplicationController
  def index
    @app_logo = PhotoBuilder.app_photo_info
  end
end