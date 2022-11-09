require 'httparty'


class GithubService
  def usernames
    get_url("/contributors")
  end

  def repo
    get_url("")
  end

  def prs
    get_url("/pulls?state=all")
  end

  def commits(username)
    get_url("/commits?author=#{username}")
  end

  def get_url(arg)
    response = HTTParty.get("https://api.github.com/repos/DarbySmith/little-esty-shop#{arg}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
