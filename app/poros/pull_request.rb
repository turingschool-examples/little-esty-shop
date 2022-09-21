class PullRequest
  attr_reader :total_count

  def initialize(repo_data)
    @total_count = repo_data[:total_count]
  end
end
