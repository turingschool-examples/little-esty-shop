require './app/poro/avatar'
require './app/service/esty_service'

class AvatarSearch
  def repo_avatars
    avatars = Avatar.new(service.repo_usernames)
    avatars.avatar_urls
  end

  def service
    EstyService.new
  end
end
