require 'httparty'

class GitService

  def get_url(url)
    response = HTTParty.get(url)
    JSON.parse(response.body, symobolize_names: true)
  end

  def commits
    get_url("https://api.github.com/repos/jaredhardinger/little-esty-shop/contributors")
  end
end
