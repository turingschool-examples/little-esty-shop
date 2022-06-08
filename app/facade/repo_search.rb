require './app/poro/esty'
require './app/service/esty_service'

class RepoSearch
  def repo_information
    Repo.new(service.repo)
  end

  def service
    EstyService.new
  end
end

