class GithubService < BaseService
  def get_url(url)
    response = conn('https://api.github.com').get("/repos/LukeSwenson06/little-esty-shop#{url}") # proper way to use faraday
    get_json(response)
  end

  def repo
    get_url("")
  end

  def contributor
    get_url('/contributors')
  end
end
