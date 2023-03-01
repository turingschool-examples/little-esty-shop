class Contributor
  attr_reader :user_name, :commits

  def initialize(data)
    @user_name = data[:login]
    @commits = data[:contributions]
  end
end