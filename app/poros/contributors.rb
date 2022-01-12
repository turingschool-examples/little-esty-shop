class Contributors
  attr_reader :commits, :username

  def initialize(data)
    #data_hash = Hash.new(data)
    #require "pry"; binding.pry
    @commits = data[:contributions]
    @username = data[:login]
  end
end
