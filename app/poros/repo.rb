class Repo
  attr_reader :name,
              :contributors

  def initialize(repo_data)
    @name = repo_data[:name]
  end
end
