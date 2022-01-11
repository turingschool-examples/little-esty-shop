class Commit

  attr_reader :commit_id,
              :commit_author

  def initialize(data)
    @commit_id = data[:sha]
    @commit_author = data[:author][:login]
  end

  # def filter_by_user_and_count(user_name)
  #   @commits.select { |commit| commit.commit_author == contributor.user_name }
  # end
end
