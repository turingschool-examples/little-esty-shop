class UserInfo

  def initialize(user_data)
    require "pry"; binding.pry
    @user_name = user_data[:login]
    @user_url = user_data[:url]
  end

end
