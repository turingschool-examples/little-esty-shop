class Commit

  def initialize(data)
    @commit_id = data[:sha]
    @commit_author = data[:author][:login]
  end
end
