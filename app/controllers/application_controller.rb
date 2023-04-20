class ApplicationController < ActionController::Base
  @image_search = ImageSearch.new
  @logo = @image_search.images("Big Pharma")
end
