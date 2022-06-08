require 'httparty'
require 'pry'
require 'json'

response = HTTParty.get("https://api.github.com/repos/ColinReinhart/little-esty-shop")
JSON.parse(response.body, symbolize_names: true)
binding.pry
