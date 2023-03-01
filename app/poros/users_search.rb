require './app/services/github_service'
require './app/poros/users'


class UsersSearch
  def service 
    GithubService.new
  end

  def users_information
    service.users.map do |data|
      User.new(data)
    end 
  end
end
