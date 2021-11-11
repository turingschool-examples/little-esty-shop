class GithubUsers
  def initialize(data)
    @data = data
  end

  def user_and_contributions
    contribution_hash = {}
    @data.each do |user|
      contribution_hash[user[:login]] = [user[:contributions]].first
    end
    contribution_hash
  end
end
