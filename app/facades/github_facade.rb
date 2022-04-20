class GithubFacade

  def repo_name
    service.repo_name.map do |data|
      RepoName.new(data)
    end
  end

  def service
    GithubService.new
  end

  def contributor_pull_requests
    pr_history = service.get_all_pull_requests
    count = Hash.new(0)
    pr_history.each{ |pr|
      # binding.pry
      count[pr["user"]["login"]]+=1
    }
    count
  end

end
