https://github.com/ColinReinhart/little-esty-shop/pull/110/conflict?name=app%252Fcontrollers%252Fapplication_controller.rb&ancestor_oid=0c72b822e7d71713023c2a70e373ebe89cb84281&base_oid=eeffee29caf49e3ca962cfa0bc247251f50dd044&head_oid=c146d884d10544b5075a86de38b1cc2173dc51fcclass EstyService


  def repo
    get_url("https://api.github.com/repos/ColinReinhart/little-esty-shop")
  end
  
  def repo_usernames
    get_url("https://api.github.com/repos/ColinReinhart/little-esty-shop/contributors")
  end

  def commits(url)
    get_url(url)
  end

  def prs
    get_url("https://api.github.com/repos/ColinReinhart/little-esty-shop/pulls?state=closed&per_page=100'")
  end

  def get_url(url)
    response = HTTParty.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
