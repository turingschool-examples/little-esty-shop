require './app/services/github_service'
require './app/poros/users_search'

class User 
  attr_reader :username, :commit_count

  def initialize(data)
   @username = data[:author][:login]
	 @commit_count = data[:total]
  end
end