class Contributors
  attr_reader :commits, :username

  def initialize(data)
    data_hash = Hash.new(data)
    needed_info = data_hash[:contributions]
    @commits = needed_info[:contributions]
    @username = needed_info[:login]
  end
end
