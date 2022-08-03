class GithubFacade
    def self.contributors
        parsed = GithubService.contributors_of_project
        @githubs = parsed.map do |contributor_data|
            Contributor.new(contributor_data)
        end
    end

    def self.pull_requests
        parsed = GithubService.pull_requests_of_project
        @githubs = parsed.map do |pull_data|
            Pull.new(pull_data)
        end
    end

    def self.repo_name
      parsed = GithubService.repo_name
      @repo_name = Repo.new(parsed[:name])
      # @githubs = parsed.map do |repo_data|
      #   require "pry"; binding.pry
      #   Repo.new(repo_data)
    end
end
