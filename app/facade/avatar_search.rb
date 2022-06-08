require './app/poro/avatar'
require './app/service/esty_service'

class AvatarSearch
  def repo_avatars
    Avatar.new(service.repo_usernames)
  end

  def service
    EstyService.new
  end
end
