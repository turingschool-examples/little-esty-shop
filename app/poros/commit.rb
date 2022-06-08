class Commit

  attr_reader :commit

  def initialize(commits)
    @commits = commits
    @commit_count_hash = Hash.new(0)
  end

  def count(contributor)
    @commits.each do |commit|
      @commit_count_hash[commit[:author][:login]] += 1
    end
    @commit_count_hash[contributor]
  end
end
