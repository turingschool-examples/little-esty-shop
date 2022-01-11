require 'httparty'
require 'json'
require 'pry'
require './app/poros/repo'
require './app/poros/user_info'
require './app/poros/commit'
require './app/poros/pull_request'

response = HTTParty.get("https://api.github.com/repos/Sierra-T-9598/little-esty-shop")
parsed = JSON.parse(response.body, symbolize_names: true)

repo = Repo.new(parsed[:name])

#####

user_response = HTTParty.get("https://api.github.com/repos/Sierra-T-9598/little-esty-shop/contributors")
user_parsed = JSON.parse(user_response.body, symbolize_names: true)

users = user_parsed.map do |user_data|
  UserInfo.new(user_data)
end

#####

commits_response = HTTParty.get("https://api.github.com/repos/Sierra-T-9598/little-esty-shop/commits")
commits_parsed = JSON.parse(commits_response.body, symbolize_names: true)

commits = commits_parsed.map do |commit_data|
  Commit.new(commit_data)
end

#####

pulls_response = HTTParty.get("https://api.github.com/repos/Sierra-T-9598/little-esty-shop/pulls")
pulls_parsed = JSON.parse(pulls_response.body, symbolize_names: true)

pulls = pulls_parsed.map do |pull_data|
  Pull.new(commit_data)
end

require "pry"; binding.pry
