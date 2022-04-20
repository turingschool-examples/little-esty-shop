require '../poros/pull_request.rb'
require '../services/github_service.rb'

class PullRequestFacade

  def service
    GithubService.new
  end

  def contributor_pull_requests
    history = service.get_all_pull_requests
    count = Hash.new(0)
    history.each{ |pr| count[pr[:user][:login]]+=1 }
    count
  end
  
end
