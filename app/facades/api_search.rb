class ApiSearch
  def repo_information
    Repo.new(@_repo_information ||= service.repo)
  end

  def pull_requests
    PullRequests.new(@_pull_request_information ||= service.pull_requests)
  end

  def commit_count(username)
    service.commits(username).count
  end

  def service
    GithubService.new
  end
end
