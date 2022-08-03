class PullRequests
  attr_reader :total_pull_requests
  
  def initialize(data)
    @total_pull_requests = data.count
  end
end
