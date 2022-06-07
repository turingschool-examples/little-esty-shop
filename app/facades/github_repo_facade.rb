class GithubRepoFacade
  def service
    GithubRepoService.new
  end

  def full_repo
    GithubRepo.new(service.repo_data)
  end
end
