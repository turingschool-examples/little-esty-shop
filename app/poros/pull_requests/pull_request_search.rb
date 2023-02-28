class PullRequestSearch

  # `pull_request_info` is the method within the API call that tells which API endpiont to fetch 
  def pull_request_info
    service.pull_requests.map do |data| 
      PullRequest.new(data)
    end 
  end

  # `service`is creating a new GithubService object
  # that carries the API call url & parsed data
  def service
    GithubService.new
  end
end