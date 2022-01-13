class Pulls
  attr_reader :number

  def initialize(data)
    if data.class == Array
       @number = data[1]
    else
       @number = data[:number]
    end
  end
end
