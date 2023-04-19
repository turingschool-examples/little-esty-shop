require 'httparty'
require 'json'
require '/app/services/unsplash_service.rb'
require '/app/poros/photo.rb'

class PhotoService 
  def get_logo
    get
  end
end