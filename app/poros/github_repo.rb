class GitHubRepo
  attr_reader :full_name,
              :name
  def initialize(data)
    @name = data[:name]
    @full_name = data[:full_name]
  end
end