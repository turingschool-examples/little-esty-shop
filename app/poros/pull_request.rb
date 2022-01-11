class PullRequest

  attr_reader :title,
              :user_name 

  def initialize(data)
    
    @title = data[:title]
    @user_name = data[:user][:login]
  end
end
