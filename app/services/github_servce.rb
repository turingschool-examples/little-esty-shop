require 'httparty'
require 'json'
require 'pry'
# require './lib/film'
# require './lib/ghibli_service'

data = HTTParty.get 'https://api.github.com/repos/Penitent0/little-esty-shop'

parsed = JSON.parse(data.body, symbolize_names: true)
binding.pry