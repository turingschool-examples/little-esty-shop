class PullRequest

  attr_reader :count

  def initialize(pull_requests)
    @count = pull_requests.count
  end
end
