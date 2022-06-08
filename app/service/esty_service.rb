class EstyService  

  def repo
    get_url("https://api.github.com/repos/ColinReinhart/little-esty-shop")
  end

  def repo_usernames
    get_url("https://api.github.com/repos/ColinReinhart/little-esty-shop/contributors")
  end

  def get_url(url)
    response = HTTParty.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
