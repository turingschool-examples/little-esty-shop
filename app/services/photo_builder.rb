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
end