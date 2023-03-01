require './app/poros/repo'
require './app/services/github_service'

class GithubFacade
  def repo
    Repo.new(service.repos[:name])
  end

  def pull_requests
    PullRequests.new(service.pulls.length)
  end

  def contributors
    contributor_logins = ["hwryan12", "aj-bailey", "GreenGogh47", "DMTimmons1"]

    service.contributors.map do |data| 
      Contributor.new(data)
    end.select { |contributor| contributor_logins.include?(contributor.user_name) }
  end

  def service
    GithubService.new
  end
end