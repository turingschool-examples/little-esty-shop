class Contributor
  attr_reader :name, :commits
  def initialize(data)
    @name = data[:login]
    @commits = data[:contributions]
  end
end
