class UserInfo

  attr_reader :user_name,
              :user_url

  def initialize(user_data)
    @user_name = user_data[:login]
    @user_url = user_data[:url]
  end
end
