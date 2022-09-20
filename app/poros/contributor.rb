class Contributor
  attr_reader :login, :contributions
  
  def initialize(data)
      @login = data[:login]
      @contributions = data[:contributions]
  end
end