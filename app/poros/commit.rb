class Commit
  attr_reader :username, :commit_count

  def initialize(data)
    @username = data[:login]
    @commit_count = data[:commit].count
  end
end
