class Contributors
  attr_reader :commits, :username

  def initialize(data)
    if data.class == Array
      @commits = data[1]
      @username = data[1]
    else
      @commits = data[:contributions]
      @username = data[:login]
    end
  end
end 

