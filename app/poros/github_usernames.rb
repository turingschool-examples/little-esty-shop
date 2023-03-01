require 'json'
require 'pry'
require './app/poros/username_search'

usernames = UsernameSearch.username_information

usernames.each do |username|
  puts "Contributor: #{username.login}"
  puts ""
end

