require 'httparty'
require 'json'
require 'pry'
require './app/poros/username_search'

  search = UsernameSearch.new

  search.username_information.each do |name|
    puts "Made by #{name.login}"
  end
