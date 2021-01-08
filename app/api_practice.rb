require 'pry'
require 'faraday'
require 'json'
require 'lib/app/models/repo'

response = Faraday.get("https://api.github.com/repos/aetzion1/little-esty-shop")
parsed = JSON.parse(response.body, symbolize_names: true)
binding.pry
parsed.map do |data|
    binding.pry
    Repo.new(data)
end