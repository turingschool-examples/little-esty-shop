require 'httparty'

class GithubService
  def self.commits(user)
    HTTParty.get("https://api.github.com/repos/Rileybmcc/little-esty-shop/commits?author=#{user}&per_page=200")
  end

  def self.pull_requests
    HTTParty.get("https://api.github.com/repos/Rileybmcc/little-esty-shop/pulls?state=closed")
  end

end
