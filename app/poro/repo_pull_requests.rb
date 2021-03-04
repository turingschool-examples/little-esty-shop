class RepoPullRequests
  attr_reader :pull_request

  def initialize
    @service = GithubService.new
    @pull_request ||= repo_pull_request
  end

  def repo_pull_request
    @service.pull_request
  end
end
