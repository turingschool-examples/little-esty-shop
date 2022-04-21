class Contributors
  attr_reader :logins

  def initialize(data)
    @logins = data.map { |contributor| contributor[:login] }
  end
end