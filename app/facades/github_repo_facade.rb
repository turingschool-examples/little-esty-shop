class GithubRepoFacade
  def service
    GithubRepoService.new
  end

  def repo_name
    GithubRepo.new(service.repo_data)
  end
end
