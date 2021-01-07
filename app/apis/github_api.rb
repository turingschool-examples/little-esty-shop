require 'faraday'
require 'pry'
require 'json'

class GithubApi

  def get_contributors
    response = Faraday.get 'https://api.github.com/repos/aidenmendez/little-esty-shop/contributors'
    body = response.body
    parse = JSON.parse(body, symbolize = true)
  end
end