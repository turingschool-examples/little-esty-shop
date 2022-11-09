class Contributor 
  attr_reader :name, :num_commits

  def initialize(data)
    @name = data[:author][:login]
    @num_commits = data[:total]
  end
end