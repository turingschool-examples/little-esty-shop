class Commit
  attr_reader :author, :num_commits

  def initialize(data)
    @num_commits = data[:total]
    @author = data[:commit][:author][:name]

  end
end