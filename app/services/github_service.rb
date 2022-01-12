require 'httparty'
require 'json'

class GithubService
  def repo
    get_url("")
  end

  def contributors
    get_url("/contributors")
  end

  def pulls
    get_url("/pulls?per_page=1&state=closed")
  end

  def get_url(url)
    response = HTTParty.get("https://api.github.com/repos/LelandCurtis/little-esty-shop#{url}")
    parsed = JSON.parse(response.body, symbolize_names: true)
  end
end
