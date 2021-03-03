class RepoName
  attr_reader :name

  def initialize(data)
    # binding.pry
    @name = data[:name]
  end
end
