class Pulls
  attr_reader :number

  def initialize(data)
    data_hash = Hash.new(data)
    needed_info = data_has[:number]
    @number = needed_info[:number]
  end
end
