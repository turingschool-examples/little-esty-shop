class RepoName
  attr_reader :repo_name

  def initialize(data)
    @repo_name = data[:repo_name]
  end
end
