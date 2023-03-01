require './app/services/github_service'
require './app/poros/username'

class UsernameSearch
  def self.service
    service = GithubService.new
  end

  def self.username_information
    service.usernames.map do |data|
      Username.new(data)
    end
  end
end

