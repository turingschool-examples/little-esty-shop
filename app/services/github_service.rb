require 'httparty'

class GitHubService
  def self.request(path, auth_required = false)
    if auth_required
    token = "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"
    HTTParty.get("https://api.github.com/repos/Astrid-Hecht/little-esty-shop/#{path}", headers: {authorization: "Bearer #{token}"})
    else
      HTTParty.get("https://api.github.com/repos/Astrid-Hecht/little-esty-shop/#{path}")
    end
  end
end