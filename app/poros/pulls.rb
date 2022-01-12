class Pulls
  attr_reader :number

  def initialize(data)
    data_hash = Hash.new(data)
    @number = data_hash[:number]
  end
end
