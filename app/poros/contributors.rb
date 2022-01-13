class Contributors
  attr_reader :commits, :username

  def initialize(data)
    @commits = data[:contributions]
    @username = data[:login]
  end
end
