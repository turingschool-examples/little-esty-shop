require 'httparty'

class GitHubService
  def self.request(path, auth_required = false)
    require 'pry' ; binding.pry
    if auth_required
    HTTParty.get("https://api.github.com/repos/Astrid-Hecht/little-esty-shop/#{path}", headers: {authorization: "Bearer " + ENV['my_secret']})
    else
      HTTParty.get("https://api.github.com/repos/Astrid-Hecht/little-esty-shop/#{path}")
    end
  end
end