require "./app/services/photo_service.rb"
require 'json'
require './app/poros/photo.rb'
require 'httparty'

class PhotoBuilder
  def self.service
    PhotoService.new
  end

  def self.merchant_photo_info
    Photo.new(service.merchant)
  end

  def self.app_photo_info
    Photo.new(service.app_logo)
  end

  def self.item_photo_info(item_name)
    Photo.new(service.item(item_name))
  end
end