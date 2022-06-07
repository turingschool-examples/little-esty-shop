#poros reports back what it finds in the data - reports behavior, not data
class Repository
  attr_reader :name

  def initialize(data)
    @name = data[:name]
  end
end