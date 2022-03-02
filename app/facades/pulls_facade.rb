class PullsFacade
  def self.count_pulls
    json = PullsService.num_pull_requests
    Pulls.new(json)
  end
end
