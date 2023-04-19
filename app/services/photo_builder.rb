require 'httparty'
require 'json'
require './app/services/photo_service.rb'
require './app/poros/photo.rb'

class PhotoBuilder
  def self.service
    PhotoService.new
  end

  def self.logo_img
    Photo.new(service.get_logo)
  end

  def self.item_img(name)
    Photo.new(service.get_item(name))
  end
end