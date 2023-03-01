class ContributorsFacade
  
  def self.get_contributor(arg)
    contributors = GithubService.fetch_contributors(arg)
    contributors.map do |contributor|
      Contributor.new(contributor)
    end
  end
end