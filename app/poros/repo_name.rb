class RepoName
  attr_reader :name
  def initialize(data)
    @name = data[:name]
#    @name = data[:name].match("little-esty-shop")
  end
end
