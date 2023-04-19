require 'httparty'

class PhotoService
  def get_url(url)
    response = HTTParty.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def merchant
    get_url("https://api.unsplash.com/photos/random?client_id=FlgsxiCZm-o34965PDOwh6xVsDINZFbzSwcz0__LKZQ&query=merchant")
  end

  def app_logo
    get_url("https://api.unsplash.com/photos/5Fxuo7x-eyg?client_id=aOXB56mTdUD88zHCvISJODxwbTPyRRsOk0rA8Ha-cbc")
  end

  def item(item_name)
    get_url("https://api.unsplash.com/photos/random?client_id=mj7CJdgJJnWWE_PL83njw8RsU79x54iA4g5bHKlM_wA&query=#{item_name}")
  end
end