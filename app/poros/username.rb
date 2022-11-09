class Username
  attr_reader :username

  def initialize(data)
    # binding.pry
    @username = data[:login]
  end
end
