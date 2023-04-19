class ImageSearch
  def images(query)
    service.images(query).map do |data|
      Image.new(data)
    end
  end

  def service
    UnsplashService.new(api_key)
  end

  def api_key
    'w9Yy1u67MS8CGViG6bLxKxs4u1RWJFMWBAn39r9be5Y'
  end
end