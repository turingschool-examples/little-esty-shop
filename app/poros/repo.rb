class Repo
  attr_reader :name

  def initialize(data)
    require 'pry'; binding.pry
    @name = data[:name]
  end
end