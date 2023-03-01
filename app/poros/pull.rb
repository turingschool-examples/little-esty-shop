class Pull
  attr_reader :user
  def initialize(data)
    @user = data[:user][:login]
  end
end