class PullRequests
  attr_reader :pull_request_count

  def initialize(data)
    @pull_request_count = data
  end
end