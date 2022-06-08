class Commit
  attr_reader :author

  def initialize(parsed_commits)
    @author = parsed_commits[:author]
  end
end
