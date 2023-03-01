class GithubInfo
  attr_reader :repo_name, :contributors, :pr_count, :commits, :commits2, :commits3
  
  def initialize(info)
    @repo_name = info[:repo_name]
    @contributors = info[:contributors]
    @commits = info[:commits]
    @pr_count = info[:pr_count]
  end

end