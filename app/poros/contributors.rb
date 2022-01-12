class Contributors
  attr_reader :commits, :username

  def initialize(data)
    data_hash = Hash.new(data)
    @commits = data_hash[:contributions]
    @username = data_hash[:login]
  end
end
