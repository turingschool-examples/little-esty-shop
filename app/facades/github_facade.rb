class GithubFacade
  class << self
    def repository
      repository = GithubService.repository
      GithubRepo.new(repository)
    end

    def users
      users = GithubService.users
      GithubUsers.new(users)
    end
  end
end
