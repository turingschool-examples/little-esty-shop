class WelcomeController < ApplicationController
  def index
    @image_search = ImageSearch.new
    @logo = @image_search.images("Big Pharma")
  end
end
