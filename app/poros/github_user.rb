class GithubUser
  attr_reader :contributors,
              :commits,
              :pull_requests

  def initialize(username, repo_name)
    github_data = GithubAPI.user_info(username, repo_name)
    @contributors = GithubAPI.contributors(username, repo_name)
    @pull_requests = GithubAPI.merged_pull_requests(username, repo_name)
  end

  def names_and_commits
    names = @contributors.map do |contributor|
      contributor[:login]
    end

    commits = @contributors.map do |contributor|
      contributor[:contributions]
    end

    combined_names_and_commits = names.zip(commits)
  end

  def total_merged_prs
    @pull_requests.count
  end
end
