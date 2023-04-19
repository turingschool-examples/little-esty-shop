require 'httparty'

class PhotoService 
  def get_url(url)
    response = HTTParty.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def get_logo
    get_url("https://api.unsplash.com/photos/C8sH11WxjYE?client_id=_VRZaA4Cz8JuLunDFcNISWMY36sxkTdZA6cEeqMGq50")
  end

  def get_item(name)
    get_url("https://api.unsplash.com/photos/random?client_id=_VRZaA4Cz8JuLunDFcNISWMY36sxkTdZA6cEeqMGq50&query=#{name}")
  end
end