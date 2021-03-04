class PullRequest
  attr_reader :pull_requests

  def initialize(repo_data)
    @pull_requests = repo_data.count
  end
end
