require 'pry'
require 'httparty'
require './app/poros/username'
require './app/poros/username_service'

class UsernameSearch
  def username_information
     service.usernames.map do |data|
       Username.new(data)
    end
  end

  def service
    UsernameService.new
  end
end
