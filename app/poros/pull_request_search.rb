class PullRequestSearch 
  def service 
    GithubService.new
  end

  def merged_pull_requests 
    prs = service.pull_requests.map do |data|
      PullRequest.new(data)
    end

    prs.select do |pr|
      pr.merged_at != nil
    end
  end

  def merged_pr_count
    merged_pull_requests.count
  end
end