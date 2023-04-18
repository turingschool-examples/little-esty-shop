require 'httparty'

class PhotoService
  def get_url(url)
    response = HTTParty.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def merchant
    get_url("https://api.unsplash.com/photos/random?client_id=FlgsxiCZm-o34965PDOwh6xVsDINZFbzSwcz0__LKZQ&query=merchant")
  end
end