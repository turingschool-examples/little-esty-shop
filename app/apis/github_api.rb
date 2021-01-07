require 'faraday'
require 'pry'
require 'json'

class GithubApi
  def self.get_contributors
    response = Faraday.get 'https://api.github.com/repos/aidenmendez/little-esty-shop/contributors'
    body = response.body
    parse = JSON.parse(body, symbolize_names: true)
  end

  def self.get_repo
      response = Faraday.get 'https://api.github.com/repos/aidenmendez/little-esty-shop'
      body = response.body
      parsed = JSON.parse(response.body, symbolize_names: true)
  end

  def self.get_commits
    response = Faraday.get 'https://api.github.com/repos/aidenmendez/little-esty-shop/commits?per_page=1&sha=2a81ea51cafe120b43d07cc5108581149c61168e'
    body = response.body
    parsed = JSON.parse(response.body, symbolize_names: true)
    parsed.count do |response|
      response[:commit]
    end
  end
end
