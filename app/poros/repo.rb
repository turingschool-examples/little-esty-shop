class Repo
  attr_reader :name, :pr_count
  def initialize(repo_info, pr_info)
    @name = repo_info["name"]
    @pr_count = pr_info["total_count"]
  end
end
