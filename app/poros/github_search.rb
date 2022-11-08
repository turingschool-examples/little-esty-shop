require "./app/poros/repo"
require "./app/services/github_service"

class GithubSearch
  def repo_information
    data = service.repo_name[:name]
    Repo.new(data)
  end

  def service
    GithubService.new
  end

  def contributor_names
    service.contributors.map do |data|
      Contributor.new(data)
    end
  end

  def num_pulls
    data = service.pull_requests[0]
    latest_pull = Pull.new(data)
  end
end
