class GithubResults
  attr_reader :username, :total_commits

  def initialize(data)
    @username = data[:author][:login]
    @total_commits = data[:total]
  end
end
