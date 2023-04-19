class UnsplashService

  def initialize(api_key)
    @api_key = api_key
  end

  def images(query)
    options = {
      query: {
        query: query,
        client_id: @api_key
      }
    }
    get_url('https://api.unsplash.com/search/photos', options)
  end

  def get_url(url, options)
    response = HTTParty.get(url, options)
    JSON.parse(response.body, symbolize_names: true)[:results]
  end
end