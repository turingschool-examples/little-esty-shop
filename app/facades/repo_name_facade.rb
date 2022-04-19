class RepoNameFacade
  def repo_name
    service.repo_name.map do |data|
      RepoName.new(data)
    end
  end

  def service
    GithubService.new
  end
end
