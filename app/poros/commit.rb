class Commit

  attr_reader :commit

  def initialize(commits)
    @commits = commits
  end

  def usernames(contributor)
    @usernames.each do |user|
      @commit_count_hash[user] += 1
    end
    @commit_count_hash[contributor]
  end
end
  #
  # def count(contributor)
  #   @usernames.each do |user|
  #     @commit_count_hash[user] += 1
  #   end
  #   @commit_count_hash[contributor]
  # end
