class GithubFacade
    def self.contributors
        parsed = GithubService.contributors_of_project
        @githubs = parsed.map do |contributor_data|
            Contributor.new(contributor_data)
        end
    end
end