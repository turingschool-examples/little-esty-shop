class Commit
  attr_reader :author, :num_commits

  def initialize(data)
    @num_commits = data[:total]
    @author = data[:author][:login]
  end
end