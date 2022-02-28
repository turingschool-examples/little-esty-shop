class ContributorFacade
  def self.find_contributor
    json = ContributorService.search_contributors
    contributors = json.map do | data |
      Contributor.new(data)
    end
  end
end
