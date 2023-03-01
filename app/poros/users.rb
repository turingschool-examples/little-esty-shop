require './app/services/github_service'
require './app/poros/users_search'

class User 
  attr_reader :username

  def initialize(data)
   @username = data[:login]
  end
end