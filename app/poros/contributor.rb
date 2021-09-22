class Contributor
  attr_reader :name, :commits
  def initialize(contributor_info)
    @name = contributor_info['author']["login"]
    @commits = contributor_info["total"]
  end
end
