class Contributor
  attr_reader :login, :commits

  def initialize(repo_data)
    @login = repo_data[:login]
    @commits = repo_data[:contributions]
  end
end
