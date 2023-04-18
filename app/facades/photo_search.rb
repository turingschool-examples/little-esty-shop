require './app/services/unsplash_service'

class PhotoSearch

  def logo
    Photo.new(service.get_logo)
  end

  def random_photo
    Photo.new(service.image_random)
  end

  def search_result(search_term)
    Photo.new(service.search_photos(search_term))
  end

  def service
    UnsplashService.new
  end
end