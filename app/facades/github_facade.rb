class GithubFacade

  def self.info_hash
   info = {
    repo_name: get_repo_name,
    contributors: get_contributors,  
    commits: get_commits,
    pr_count: get_pr_count
    }
   GithubInfo.new(info)
  end

  def self.get_repo_name
    git_name = GithubService.fetch_api("")
    git_name[:name]
  end

  def self.get_contributors
    contributors = GithubService.fetch_api("/contributors")
    contributors.map do |contributor|
      contributor[:login]
    end
  end

  def self.get_commits
    commits = GithubService.fetch_api("/stats/contributors")
    new_hash = {}
    commits.map do |individual|
      new_hash[individual[:author][:login]]= individual[:total]
    end
    return new_hash
  end


  def self.get_pr_count
    all_closed_prs = GithubService.fetch_api("/pulls?state=closed")
    x = all_closed_prs.map do |pr|
      pr[:number]
    end.first
  end
end