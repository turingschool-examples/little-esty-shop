require 'httparty'
require 'pry'

class GithubService 
    # response = HTTParty.get('https://api.github.com/repos/bensjsilverstein/little-esty-shop')
    response = HTTParty.get('https://api.github.com/repos/bensjsilverstein/little-esty-shop/contributors')

    body = response.body

    parsed = JSON.parse(body, symbolize_names: true)

    binding.pry
end