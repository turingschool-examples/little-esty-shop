# require 'httparty'
# require 'json'
# require 'pry'
# require './app/services/unsplash_service'
# require './app/poros/image'
# require './app/poros/image_search'

# image_search = ImageSearch.new
# images = image_search.images('star wars')
# # # query = 'star wars'

# images.each do |image|
#   require 'pry'; binding.pry
#   puts image.alt_description
# end


# response = HTTParty.get('https://api.unsplash.com/search/photos?query=star%20wars&client_id=w9Yy1u67MS8CGViG6bLxKxs4u1RWJFMWBAn39r9be5Y')
# parsed = JSON.parse(response.body, symbolize_names: true)[:results]

# parsed.each do |image|
#   puts image[:alt_description]
# end
# require 'pry'; binding.pry