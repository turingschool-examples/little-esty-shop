class GithubFacade

  def self.info_hash
   info = {
    repo_name: get_repo_name,
    contributors: get_contributors
    # commits: get_commits,
    # pr_count: get_pr_count
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

  # def self.get_commits
  #   commits = GithubService.fetch_api("/commits")
  #   commits.map do |commit|
  #     commit
  #   end
  # end

  # def self.get_pull_requests

  # end
end