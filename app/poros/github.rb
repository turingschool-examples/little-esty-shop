class GitHubRepo
  attr_reader :full_name,
              :name,
              :id
  def initialize(data)
    @name = data[:name]
    @full_name = data[:full_name]
    @id = data[:id]
  end
end