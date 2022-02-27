class Contributor
  attr_reader :name
  def initialize(data)
    @name = data[:login]
  end
end
