class Contributor
  attr_reader :name, :commits, :id
  def initialize(data)
    @name = data[:login]
    @commits = data[:contributions]
    @id = data[:id]
  end
end
