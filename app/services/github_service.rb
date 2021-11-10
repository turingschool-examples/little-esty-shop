class GithubService

  TURING_STAFF = %w(BrianZanti timomitchel scottalexandra jamisonordway)

  def initialize
  end

  def name_info
    repo_name_info[:name]
  end

  def contributors_commits
    repo_contributors_commits.filter_map do |contributor|
      if !TURING_STAFF.include?(contributor[:author][:login])
        "#{contributor[:author][:login]} with #{contributor[:total]} commits"
      end
    end
  end

  def pr_count
    repo_pr_count.count do |pull|
      !TURING_STAFF.include?(pull[:user][:login])
    end
  end

  private

  def repo_name_info
    @name = GithubClient.repo_info
  end

  def repo_contributors_commits
    @contributors_commits = GithubClient.repo_contributors
  end

  def repo_pr_count
    @pull_requests_count = GithubClient.pr_info
  end


end
