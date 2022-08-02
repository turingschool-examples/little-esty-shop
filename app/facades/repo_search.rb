class RepoSearch
  # memoization
  def repo_information
      Repo.new(@_repo_information ||= service.repo)
  end

  def commit_count(username)
    service.commits(username).count
  end

  def service
    GithubService.new
  end
  # binding.pry
end
