class Contributor
  attr_reader :login

  def initialize(repo_data)
    @login = repo_data[:login]
  end
end
