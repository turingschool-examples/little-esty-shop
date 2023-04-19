require 'httparty'
require 'json'

class UnsplashService
  class UnsplashService
    response = HTTParty.get("https://unsplash.com/oauth/applications/438268")
    # require 'pry'; binding.pry
    parsed = JSON.parse(response.body, symbolize_names: true)
  end
end