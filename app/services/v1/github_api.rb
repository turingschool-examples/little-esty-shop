require 'faraday'
require 'pry'
require 'json'

class GithubApi
  response = Faraday.get 'https://api.github.com/repos/aidenmendez/little-esty-shop/contributors'

  body = response.body
end