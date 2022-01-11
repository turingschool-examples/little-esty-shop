class GithubSearch
  
  def repo_information
    repo = Repo.new(service.repo.[:name])
  end

  def contributor_information
    service.contributors.map do |data|
      UserInfo.new(data)
    end
  end

  def commit_information
    service.commits.map do |data|
      Commit.new(data)
    end
  end

  def pull_request_information
    service.pull_requests.map do |data|
      PullRequest.new(data)
    end
  end

  def service
    GithubService.new
  end
end
