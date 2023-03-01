class GithubInfo
  attr_reader :repo_name, :contributors
  
  def initialize(info)
    @repo_name = info[:repo_name]
    @contributors = info[:contributors]
    @commits = info[:commits]
    @pr_count = info[:pr_count]
  end
end