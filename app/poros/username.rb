require 'pry'

class Username
  attr_reader :name

  def initialize(data)
    binding.pry
    @name = data[:login]
  end
end
