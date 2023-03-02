class GithubInfo
  attr_reader :repo_name,
              :collaborators,
              :pulls

  def initialize(info)
    @repo_name = info[:repo_name]
    @collaborators = info[:collaborators]
    @pulls = info[:pulls]
  end
end