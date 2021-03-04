class Commit
  attr_reader :author_name,
              :author_email,
              :committer_name,
              :committer_email,
              :message

  def initialize(data)
    @author_name = data[:author][:name]
    @author_email = data[:author][:email]
    @committer_name = data[:committer][:name]
    @committer_email = data[:committer][:email]
    @message = data[:message]
  end
end