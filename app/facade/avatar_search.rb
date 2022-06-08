require './app/poro/avatar'
require './app/service/esty_service'

class AvatarSearch
  def repo_information
    Avatar.new(service.repo_usernames)
  end

  def service
    AvatarSearch.new
  end
end
