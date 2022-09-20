require 'httparty'

class GitHubService
  def self.request(path, auth_required = false)
    if auth_required
      HTTParty.get("https://api.github.com/repos/Astrid-Hecht/little-esty-shop/#{path}")
    else
      HTTParty.get("https://api.github.com/repos/Astrid-Hecht/little-esty-shop/#{path}")
    end
  end
end