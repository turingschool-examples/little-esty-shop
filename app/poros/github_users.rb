class GithubUsers
  def initialize(data)
    @data = data
  end

  def get_users
    users = []
    @data.each do |user|
      users << user[:login]
    end
    users
  end
end