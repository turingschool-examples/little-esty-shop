class PullRequest

  def initialize(data)
    @title = data[:title]
    @user_name = data[:user][:login]
  end
end
