class ContributorFacade
  def self.find_contributor
    json = ContributorService.search_contributors
    contributors = json.map do | data |
      Contributor.new(data)
    end
  end

  def self.num_pull_requests
    json = ContributorService.num_pull_requests
    json[:data].map do | data |
      Contributer.new(data)
    end
  end
end
