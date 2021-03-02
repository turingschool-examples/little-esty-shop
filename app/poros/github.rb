class Github
  attr_reader :name

  def initialize(data)
    @name = data[:name]
    require "pry";binding.pry
  end
end
