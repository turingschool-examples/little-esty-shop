class GithubInfo
  attr_reader :repo_name

  def initialize(info)
    @repo_name = info[:repo_name]
  end
end