require 'httparty'

class GitHubService
  def self.request(path)
    token = "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"
    HTTParty.get("https://api.github.com/repos/Astrid-Hecht/little-esty-shop/#{path}", headers: {authorization: "token #{token}"})
  end
end