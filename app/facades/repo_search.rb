class RepoSearch
  # memoization
  def repo_information
      Repo.new(@_repo_information ||= service.repo)
  end

  def service
    GithubService.new
  end
  # binding.pry
end
