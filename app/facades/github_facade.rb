class GithubFacade
  class << self
    def repository
      repository = GithubService.repository
      GithubRepo.new(repository)
    end
  end
end
