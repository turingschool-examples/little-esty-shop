require 'httparty'

class GithubService
  def self.commits
    HTTParty.get("https://api.github.com/repos/Rileybmcc/little-esty-shop/commits?per_page=100")
  end
end
