class Commit

  attr_reader :commit, :usernames, :commit_count_hash

  def initialize(commits)
    @commits = commits
    binding.pry
    @usernames = commits[:author][:login]
    @commit_count_hash = Hash.new(0)
  end

  def count(contributor)
    @usernames.each do |user|
      @commit_count_hash[user] += 1
    end
    @commit_count_hash[contributor]
  end
end
