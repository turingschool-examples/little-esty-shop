class Username
  attr_reader :login

  def initialize(data)
    @data = data
  	@login = data[:login]
  end
end  
