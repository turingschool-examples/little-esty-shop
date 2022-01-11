require 'httparty'
require 'pry'
require 'json'


response = HTTParty.get("https://api.github.com/repos/croixk/little-esty-shop")


parsed = JSON.parse(response.body, symbolize_names: true)

user_name_response = HTTParty.get("https://api.github.com/repos/croixk/little-esty-shop/contributors")
user_name_parsed = JSON.parse(user_name_response.body, symbolize_names: true)

user_names = user_name_parsed.map do |user|
  user[:login]
end
binding.pry

#repo name
#user names
#commits
#pull requests

repo_name = parsed[:name]
