class RepoName
  attr_reader :name

  def initialize(data)
    @name = data[:full_name]
  end

end
