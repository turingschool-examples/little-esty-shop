class GitHubFacade

  def self.contributors
    parsed = GitHubService.get_contributors
      parsed.map do |contributor_data|
        Contributor.new(contributor_data)
      end
  end

end