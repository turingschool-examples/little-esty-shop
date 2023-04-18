require 'httparty'
require './app/poros/photo'

class UnsplashService
  @@api_key = Rails.application.config.unsplash_api_key

  def get_logo
    get_url("https://api.unsplash.com/photos/qMehmIyaXvY/?client_id=#{@@api_key}")
  end

  def image_random
    get_url("https://api.unsplash.com/photos/random/?client_id=#{@@api_key}")
  end

  def search_photos(search_term)
    result = get_url("https://api.unsplash.com/search/photos?page=1&query=#{search_term}&client_id=#{@@api_key}")
    if result[:results].empty?
      return get_error_photo
    end
    result[:results][0]
  end

  def get_error_photo
    get_url("https://api.unsplash.com/photos/Hl_o1K6OPsA/?client_id=#{@@api_key}")
  end

  def get_url(url)
    response = HTTParty.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
